-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 05 avr. 2026 à 20:25
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pfe_recruitment`
--

-- --------------------------------------------------------

--
-- Structure de la table `candidature`
--

CREATE TABLE `candidature` (
  `id_candidature` int(11) NOT NULL,
  `cv` varchar(255) DEFAULT NULL,
  `date_postule` date DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `lettre_motivation` varchar(255) DEFAULT NULL,
  `date_reponse` date DEFAULT NULL,
  `entretien_date` date DEFAULT NULL,
  `entretien_lieu` varchar(150) DEFAULT NULL,
  `note_recruteur` int(11) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `id_offre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `certification`
--

CREATE TABLE `certification` (
  `id_certif` int(11) NOT NULL,
  `date_obtient` date DEFAULT NULL,
  `university` varchar(150) DEFAULT NULL,
  `competence` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `company`
--

CREATE TABLE `company` (
  `id_company` int(11) NOT NULL,
  `nom` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `secteur` varchar(100) DEFAULT NULL,
  `pays` varchar(100) DEFAULT NULL,
  `site_web` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `company`
--

INSERT INTO `company` (`id_company`, `nom`, `description`, `logo`, `email`, `telephone`, `secteur`, `pays`, `site_web`, `type`, `id_user`) VALUES
(1, 'TechCorp', 'Leading company in TechCorp sector', NULL, 'contact@techcorp.com', NULL, 'Technology', NULL, NULL, NULL, 12),
(2, 'DesignHub', 'Leading company in DesignHub sector', NULL, 'contact@designhub.com', NULL, 'Technology', NULL, NULL, NULL, 13),
(3, 'DataTech', 'Leading company in DataTech sector', NULL, 'contact@datatech.com', NULL, 'Technology', NULL, NULL, NULL, 14),
(4, 'PM Solutions', 'Leading company in PM Solutions sector', NULL, 'contact@pm solutions.com', NULL, 'Technology', NULL, NULL, NULL, 15),
(12, 'Tech Corp 1', NULL, NULL, NULL, NULL, 'Technology', NULL, NULL, NULL, 25),
(13, 'Design Studio', NULL, NULL, NULL, NULL, 'Design', NULL, NULL, NULL, 26),
(14, 'Data Analytics Inc', NULL, NULL, NULL, NULL, 'Analytics', NULL, NULL, NULL, 27),
(15, 'Project Solutions', NULL, NULL, NULL, NULL, 'Consulting', NULL, NULL, NULL, 28),
(16, 'aeros', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8),
(17, 'Trabelsi Adem', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 22),
(18, 'Company of recruiter@test.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 23),
(19, 'club african', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 24),
(20, 'Trabelsi Adem', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 29);

-- --------------------------------------------------------

--
-- Structure de la table `demande_visa`
--

CREATE TABLE `demande_visa` (
  `id_demande` int(11) NOT NULL,
  `date_demande` date DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `commentaire_admin` text DEFAULT NULL,
  `type_visa` varchar(100) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fichier`
--

CREATE TABLE `fichier` (
  `id_fichier` int(11) NOT NULL,
  `nom` varchar(150) DEFAULT NULL,
  `date_creation` date DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `id_entreprise` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `matching`
--

CREATE TABLE `matching` (
  `id_matching` int(11) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `note` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `id_candidature` int(11) DEFAULT NULL,
  `id_offre` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `id_notif` int(11) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `lu` tinyint(1) DEFAULT 0,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notification`
--

INSERT INTO `notification` (`id_notif`, `type`, `message`, `date`, `lu`, `id_user`) VALUES
(2, 'application_received', NULL, '2026-03-27', 0, 8),
(3, 'interview_scheduled', NULL, '2026-03-27', 0, 8),
(4, 'offer_sent', NULL, '2026-03-27', 0, 8);

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE `offre` (
  `id_offre` int(11) NOT NULL,
  `titre` varchar(150) DEFAULT NULL,
  `type_contrat` varchar(100) DEFAULT NULL,
  `localisation` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `salaire` decimal(10,2) DEFAULT NULL,
  `experience` varchar(100) DEFAULT NULL,
  `date_pub` date DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `nombre_vues` int(11) DEFAULT 0,
  `date_expiration` date DEFAULT NULL,
  `id_entreprise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `offre`
--

INSERT INTO `offre` (`id_offre`, `titre`, `type_contrat`, `localisation`, `description`, `salaire`, `experience`, `date_pub`, `statut`, `nombre_vues`, `date_expiration`, `id_entreprise`) VALUES
(12, 'Senior Full Stack Developer', 'CDI', 'beja', 'We are looking for an experienced Full Stack Developer to join our growing team. You will work on modern web technologies and have the opportunity to lead technical projects.', 800.00, '5 years', '2026-04-02', 'Active', 0, '2026-05-03', 16),
(13, 'UX/UI Designer', 'CDI', 'nabeul', 'Exciting opportunity for UX/UI Designer position', 4000.00, '2+ years', '2026-02-11', 'OUVERT', 0, '2026-05-09', 16),
(14, 'Data Scientist', 'CDI', 'sfax', 'Exciting opportunity for Data Scientist position', 4000.00, '2+ years', '2026-02-10', 'OUVERT', 0, '2026-05-09', 16),
(15, 'Project Manager', 'CDI', 'sousse', 'Exciting opportunity for Project Manager position', 3500.00, '2+ years', '2026-01-15', 'FERME', 0, '2026-04-14', 16),
(16, 'Senior Full-Stack Developer', 'CDI', 'beja', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 10000.00, 'JUNIOR', '2026-04-02', 'OUVERT', 0, '2026-11-02', 16);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('ADMIN','CANDIDAT','ENTREPRISE') NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `pays` varchar(100) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `date_inscription` datetime DEFAULT current_timestamp(),
  `civilite` enum('Mr','Mme','Mlle') DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `cv` varchar(255) DEFAULT NULL,
  `niveau_etude` varchar(100) DEFAULT NULL,
  `specialite` varchar(150) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `github` varchar(255) DEFAULT NULL,
  `portfolio` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `experience` varchar(150) DEFAULT NULL,
  `nom_entreprise` varchar(150) DEFAULT NULL,
  `description_entreprise` text DEFAULT NULL,
  `identifiant_entreprise` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `secteur` varchar(100) DEFAULT NULL,
  `site_web` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_user`, `nom`, `email`, `mot_de_passe`, `role`, `telephone`, `pays`, `adresse`, `date_inscription`, `civilite`, `date_naissance`, `cv`, `niveau_etude`, `specialite`, `bio`, `avatar`, `linkedin`, `github`, `portfolio`, `is_verified`, `experience`, `nom_entreprise`, `description_entreprise`, `identifiant_entreprise`, `logo`, `secteur`, `site_web`) VALUES
(8, 'aeros', 'aeros@gmail.com', '$2b$10$UnFOs1rETzae0HDT/4finuXERVdrFcVjQofgY88z5DbchRX5Y6.nu', 'ENTREPRISE', NULL, NULL, 'Béja ', '2026-02-21 15:15:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'aeros', NULL, NULL, NULL, 'vente', 'https://aeros-advising.com/'),
(10, 'houwaida kh', 'houwaida@gmail.com', '$2b$10$wF.ChZCMUlaEcAOnsbV/r.vPHTI2mQ8X5vxmDmj8TgOUvvjEKISei', 'CANDIDAT', '58611227', NULL, NULL, '2026-02-22 14:28:35', NULL, NULL, '1773141117496-cvv.pdf', NULL, 'Développement Web', '', NULL, NULL, NULL, '1773187418969.pdf', 0, '1', NULL, 'looking for job', NULL, '1773141117495-images.jpg', NULL, NULL),
(11, 'adem', 'adem@gmail.com', '$2b$10$8vNb7BykydzVwC.lFR3PEegBoJc6c1D3uCo1PLSY9PZbmTjDQzNB.', 'CANDIDAT', NULL, 'Tunisie', 'Béja ', '2026-02-23 09:27:32', '', '2003-08-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'TechCorp Contact', 'contact@techcorp.com', '$2b$10$Yx5nMFuoGHjNpRH0CKKd.egr2KvU4Zt8qsqYouH3LY5igySpUtGKC', 'ENTREPRISE', NULL, NULL, NULL, '2026-03-27 22:12:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'TechCorp', 'Leading company in TechCorp sector', NULL, NULL, 'Technology', NULL),
(13, 'DesignHub Contact', 'contact@designhub.com', '$2b$10$K4143hZOVlHjEx1Qo.E5mutEhZos6oNqzghX5EnEeLg4iSX6iEhfy', 'ENTREPRISE', NULL, NULL, NULL, '2026-03-27 22:14:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'DesignHub', 'Leading company in DesignHub sector', NULL, NULL, 'Technology', NULL),
(14, 'DataTech Contact', 'contact@datatech.com', '$2b$10$K4143hZOVlHjEx1Qo.E5mutEhZos6oNqzghX5EnEeLg4iSX6iEhfy', 'ENTREPRISE', NULL, NULL, NULL, '2026-03-27 22:14:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'DataTech', 'Leading company in DataTech sector', NULL, NULL, 'Technology', NULL),
(15, 'PM Solutions Contact', 'contact@pm solutions.com', '$2b$10$K4143hZOVlHjEx1Qo.E5mutEhZos6oNqzghX5EnEeLg4iSX6iEhfy', 'ENTREPRISE', NULL, NULL, NULL, '2026-03-27 22:14:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'PM Solutions', 'Leading company in PM Solutions sector', NULL, NULL, 'Technology', NULL),
(16, 'Ahmed Ben Ali', 'ahmed.benali@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 20 123 456', 'Tunisia', 'Tunis', '2026-03-27 22:18:57', 'Mr', NULL, NULL, NULL, 'Full-Stack Developer', NULL, NULL, NULL, NULL, NULL, 1, '5 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'Fatma Khelifi', 'fatma.khelifi@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 21 234 567', 'Tunisia', 'Ariana', '2026-03-27 22:18:57', 'Mme', NULL, NULL, NULL, 'Data Scientist', NULL, NULL, NULL, NULL, NULL, 1, '3 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'Mohamed Trabelsi', 'mohamed.trabelsi@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 22 345 678', 'Tunisia', 'Sfax', '2026-03-27 22:18:57', 'Mr', NULL, NULL, NULL, 'Mobile Developer', NULL, NULL, NULL, NULL, NULL, 1, '4 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'Yasmine Mansouri', 'yasmine.mansouri@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 23 456 789', 'Tunisia', 'Tunis', '2026-03-27 22:18:57', 'Mme', NULL, NULL, NULL, 'UX Designer', NULL, NULL, NULL, NULL, NULL, 1, '6 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Karim Jebali', 'karim.jebali@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 24 567 890', 'Tunisia', 'Remote', '2026-03-27 22:18:57', 'Mr', NULL, NULL, NULL, 'DevOps Engineer', NULL, NULL, NULL, NULL, NULL, 1, '7 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'Sarra Bouguerra', 'sarra.bouguerra@email.com', '$2b$10$UYNWn39QY.NvQeHHJQxuXehqiEUpmkmpgp5RNN3vqy94jb9lVcbU2', 'CANDIDAT', '+216 25 678 901', 'Tunisia', 'Sousse', '2026-03-27 22:18:57', 'Mme', NULL, NULL, NULL, 'Marketing Specialist', NULL, NULL, NULL, NULL, NULL, 1, '2 years exp', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'Trabelsi Adem', 'tadem7235@gmail.com', '$2b$10$PDz8xpuLyKkNtBzaarwjTuGPM.Gx0ooBvRkJ/x5CKk3zlDR7fATbi', 'ENTREPRISE', NULL, NULL, 'gbouulat', '2026-03-30 12:01:58', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'Trabelsi Adem', NULL, NULL, NULL, 'beja', 'http://localhost:5173/'),
(23, 'Test Recruiter', 'recruiter@test.com', '$2b$10$hGk/TqeYAlAxJ637Dh/wFu0malS5GHH1eO0aX5tYoOVqRb6BL.txO', 'ENTREPRISE', NULL, NULL, NULL, '2026-04-02 09:05:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'club african', 'clubafrican@test.com', '$2b$10$2zk4gxCSgOmOG46md4EhM.BTcPtx8jTLM2628dEYaSx0.UZ72qISy', 'ENTREPRISE', NULL, NULL, 'beb jdyd', '2026-04-02 10:11:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'club african', NULL, NULL, NULL, 'foot', 'https://clubafricain.com/'),
(25, 'Recruiter 1', 'recruiter1@test.com', '$2b$10$l7KRFz2dI7C2o4uhuP4ihOwDA3eTeaFAz1Elhai3HtaLcSfljlfmK', 'ENTREPRISE', NULL, NULL, NULL, '2026-04-02 10:19:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 'Recruiter 2', 'recruiter2@test.com', '$2b$10$q6fjQZVwxLVTZW6sGxvS0uMDOITY3Q4ubjRiBBtr21cWDFljkflgC', 'ENTREPRISE', NULL, NULL, NULL, '2026-04-02 10:19:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'Recruiter 3', 'recruiter3@test.com', '$2b$10$q3skuCjg.BFChFdoTKPoIuR.6s5F9Dh/HBB5WrWNkC3g9y5iIb9t.', 'ENTREPRISE', NULL, NULL, NULL, '2026-04-02 10:19:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'Recruiter 4', 'recruiter4@test.com', '$2b$10$idJV3i5a9q0NukklsoI/OeHWnpVl9ZwrLgYyUOsgR1dfe5IRTtf72', 'ENTREPRISE', NULL, NULL, NULL, '2026-04-02 10:19:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Trabelsi Adem', 'beja@gmail.com', '$2b$10$zBQ3ht95UX3zy.4nW.hU9e6Bb5oTssUM8tItFRKfSL1Gi2PMkf7EW', 'ENTREPRISE', NULL, NULL, 'gbouulat', '2026-04-02 12:10:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'Trabelsi Adem', NULL, NULL, NULL, 'foot', 'https://clubafricain.com/'),
(30, 'Trabelsi Adem', 'ad@gmail.com', '$2b$10$6kvPzm7J0QZvH/eSbbzNyu6xcGStmMIUs8WEVhbSH15Ixbu51fHG6', 'CANDIDAT', NULL, 'Tunisie', 'gbouulat', '2026-04-02 12:11:37', 'Mr', '2023-06-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'adem', 'aeross@gmail.com', '$2b$10$xjUthKN2Inz3EsJp2E2S6up7pvt6NNKgFuHj8cCvxZ0/NY.N/Irau', 'CANDIDAT', NULL, 'Tunisie', 'beja', '2026-04-02 15:33:53', 'Mr', '2026-04-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `visa`
--

CREATE TABLE `visa` (
  `id_visa` int(11) NOT NULL,
  `pays` varchar(100) DEFAULT NULL,
  `date_creation` date DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `date_validation` date DEFAULT NULL,
  `id_demande` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `candidature`
--
ALTER TABLE `candidature`
  ADD PRIMARY KEY (`id_candidature`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_offre` (`id_offre`);

--
-- Index pour la table `certification`
--
ALTER TABLE `certification`
  ADD PRIMARY KEY (`id_certif`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id_company`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `demande_visa`
--
ALTER TABLE `demande_visa`
  ADD PRIMARY KEY (`id_demande`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `fichier`
--
ALTER TABLE `fichier`
  ADD PRIMARY KEY (`id_fichier`),
  ADD KEY `id_entreprise` (`id_entreprise`);

--
-- Index pour la table `matching`
--
ALTER TABLE `matching`
  ADD PRIMARY KEY (`id_matching`),
  ADD KEY `id_candidature` (`id_candidature`),
  ADD KEY `id_offre` (`id_offre`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id_notif`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`id_offre`),
  ADD KEY `id_entreprise` (`id_entreprise`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `visa`
--
ALTER TABLE `visa`
  ADD PRIMARY KEY (`id_visa`),
  ADD KEY `id_demande` (`id_demande`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `candidature`
--
ALTER TABLE `candidature`
  MODIFY `id_candidature` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `certification`
--
ALTER TABLE `certification`
  MODIFY `id_certif` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `company`
--
ALTER TABLE `company`
  MODIFY `id_company` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `demande_visa`
--
ALTER TABLE `demande_visa`
  MODIFY `id_demande` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fichier`
--
ALTER TABLE `fichier`
  MODIFY `id_fichier` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `matching`
--
ALTER TABLE `matching`
  MODIFY `id_matching` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `notification`
--
ALTER TABLE `notification`
  MODIFY `id_notif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `offre`
--
ALTER TABLE `offre`
  MODIFY `id_offre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `visa`
--
ALTER TABLE `visa`
  MODIFY `id_visa` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `candidature`
--
ALTER TABLE `candidature`
  ADD CONSTRAINT `candidature_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `candidature_ibfk_2` FOREIGN KEY (`id_offre`) REFERENCES `offre` (`id_offre`) ON DELETE CASCADE;

--
-- Contraintes pour la table `certification`
--
ALTER TABLE `certification`
  ADD CONSTRAINT `certification_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `demande_visa`
--
ALTER TABLE `demande_visa`
  ADD CONSTRAINT `demande_visa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fichier`
--
ALTER TABLE `fichier`
  ADD CONSTRAINT `fichier_ibfk_1` FOREIGN KEY (`id_entreprise`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `matching`
--
ALTER TABLE `matching`
  ADD CONSTRAINT `matching_ibfk_1` FOREIGN KEY (`id_candidature`) REFERENCES `candidature` (`id_candidature`) ON DELETE CASCADE,
  ADD CONSTRAINT `matching_ibfk_2` FOREIGN KEY (`id_offre`) REFERENCES `offre` (`id_offre`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offre`
--
ALTER TABLE `offre`
  ADD CONSTRAINT `offre_ibfk_1` FOREIGN KEY (`id_entreprise`) REFERENCES `user` (`id_user`) ON DELETE CASCADE;

--
-- Contraintes pour la table `visa`
--
ALTER TABLE `visa`
  ADD CONSTRAINT `visa_ibfk_1` FOREIGN KEY (`id_demande`) REFERENCES `demande_visa` (`id_demande`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
