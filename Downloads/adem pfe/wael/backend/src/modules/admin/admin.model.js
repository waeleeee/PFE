const pool = require("../../config/db");

const Admin = {
  // User CRUD
  getAllUsers: async (filters = {}) => {
    let query = "SELECT id_user, nom, email, role, telephone, pays, date_inscription, is_verified FROM user WHERE 1=1";
    const params = [];

    if (filters.search) {
      query += " AND (nom LIKE ? OR email LIKE ?)";
      params.push(`%${filters.search}%`, `%${filters.search}%`);
    }
    if (filters.role) {
      query += " AND role = ?";
      params.push(filters.role);
    }

    query += " ORDER BY date_inscription DESC";
    const [rows] = await pool.query(query, params);
    return rows;
  },

  createUser: async (data) => {
    const { nom, email, mot_de_passe, role, telephone, pays, adresse, civilite } = data;
    const [result] = await pool.query(
      "INSERT INTO user (nom, email, mot_de_passe, role, telephone, pays, adresse, civilite, is_verified, date_inscription) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, NOW())",
      [nom, email, mot_de_passe, role, telephone, pays, adresse, civilite]
    );
    return result.insertId;
  },

  updateUser: async (id, data) => {
    const fields = [];
    const values = [];
    for (const [key, value] of Object.entries(data)) {
      if (value !== undefined) {
        fields.push(`${key} = ?`);
        values.push(value);
      }
    }
    values.push(id);
    const [result] = await pool.query(
      `UPDATE user SET ${fields.join(", ")} WHERE id_user = ?`,
      values
    );
    return result.affectedRows > 0;
  },

  verifyUser: async (id, status) => {
    const [result] = await pool.query("UPDATE user SET is_verified = ? WHERE id_user = ?", [status, id]);
    return result.affectedRows > 0;
  },

  deleteUser: async (id) => {
    const [result] = await pool.query("DELETE FROM user WHERE id_user = ?", [id]);
    return result.affectedRows > 0;
  },

  // Company CRUD
  getAllCompanies: async (filters = {}) => {
    let query = "SELECT c.*, u.nom as user_name, u.email FROM company c JOIN user u ON c.id_user = u.id_user WHERE 1=1";
    const params = [];

    if (filters.search) {
      query += " AND (c.nom LIKE ? OR u.nom LIKE ?)";
      params.push(`%${filters.search}%`, `%${filters.search}%`);
    }

    query += " ORDER BY c.nom";
    const [rows] = await pool.query(query, params);
    return rows;
  },

  createCompany: async (data) => {
    const { nom, description, email, secteur, id_user } = data;
    const [result] = await pool.query(
      "INSERT INTO company (nom, description, email, secteur, id_user) VALUES (?, ?, ?, ?, ?)",
      [nom, description, email, secteur, id_user]
    );
    return result.insertId;
  },

  updateCompany: async (id, data) => {
    const fields = [];
    const values = [];
    for (const [key, value] of Object.entries(data)) {
      if (value !== undefined) {
        fields.push(`${key} = ?`);
        values.push(value);
      }
    }
    values.push(id);
    const [result] = await pool.query(
      `UPDATE company SET ${fields.join(", ")} WHERE id_company = ?`,
      values
    );
    return result.affectedRows > 0;
  },

  deleteCompany: async (id) => {
    const [result] = await pool.query("DELETE FROM company WHERE id_company = ?", [id]);
    return result.affectedRows > 0;
  },

  // Applications CRUD
  getAllApplications: async (filters = {}) => {
    let query = `SELECT c.*, u.nom as candidate_name, u.email, o.titre as job_title, o.salaire
                 FROM candidature c
                 JOIN user u ON c.id_user = u.id_user
                 JOIN offre o ON c.id_offre = o.id_offre
                 WHERE 1=1`;
    const params = [];

    if (filters.search) {
      query += " AND (u.nom LIKE ? OR o.titre LIKE ?)";
      params.push(`%${filters.search}%`, `%${filters.search}%`);
    }
    if (filters.status) {
      query += " AND c.statut = ?";
      params.push(filters.status);
    }

    query += " ORDER BY c.date_postule DESC";
    const [rows] = await pool.query(query, params);
    return rows;
  },

  updateApplicationStatus: async (id, status) => {
    const [result] = await pool.query("UPDATE candidature SET statut = ? WHERE id_candidature = ?", [status, id]);
    return result.affectedRows > 0;
  },

  deleteApplication: async (id) => {
    const [result] = await pool.query("DELETE FROM candidature WHERE id_candidature = ?", [id]);
    return result.affectedRows > 0;
  },

  // Stats
  getStats: async () => {
    const [[users]] = await pool.query("SELECT COUNT(*) as total FROM user");
    const [[offers]] = await pool.query("SELECT COUNT(*) as total FROM offre");
    const [[apps]] = await pool.query("SELECT COUNT(*) as total FROM candidature");
    const [[companies]] = await pool.query("SELECT COUNT(*) as total FROM company");
    return {
      totalUsers: users.total,
      totalOffers: offers.total,
      totalApplications: apps.total,
      totalCompanies: companies.total
    };
  },

  getReports: async () => {
    const [recentUsers] = await pool.query("SELECT nom, email, role, date_inscription FROM user ORDER BY date_inscription DESC LIMIT 5");
    const [recentOffers] = await pool.query("SELECT titre, date_pub FROM offre ORDER BY date_pub DESC LIMIT 5");
    const [applicationStats] = await pool.query("SELECT statut, COUNT(*) as count FROM candidature GROUP BY statut");
    return {
      recentUsers,
      recentOffers,
      applicationStats
    };
  }
};

module.exports = Admin;