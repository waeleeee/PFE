const interviewService = require("./interview.service");

/**
 * GET /api/interviews
 */
exports.getMyInterviews = async (req, res) => {
  try {
    const userId = req.user.id;

    const interviews = await interviewService.getMyInterviews(userId);

    res.json({
      success: true,
      data: interviews,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error fetching interviews" });
  }
};

/**
 * PATCH /api/interviews/:id/confirm
 */
exports.confirm = async (req, res) => {
  try {
    const { id } = req.params;

    await interviewService.confirmInterview(id);

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ message: "Error confirming interview" });
  }
};

/**
 * PATCH /api/interviews/:id/cancel
 */
exports.cancel = async (req, res) => {
  try {
    const { id } = req.params;

    await interviewService.cancelInterview(id);

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ message: "Error cancelling interview" });
  }
};

/**
 * PATCH /api/interviews/:id/schedule
 */
exports.schedule = async (req, res) => {
  try {
    const { id } = req.params;
    const { date } = req.body;

    if (!date) {
      return res.status(400).json({ message: "Date is required" });
    }

    await interviewService.scheduleInterview(id, date);

    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ message: "Error scheduling interview" });
  }
};