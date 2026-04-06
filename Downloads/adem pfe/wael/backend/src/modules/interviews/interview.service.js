const interviewModel = require("./interview.model");

exports.getMyInterviews = async (userId) => {
  return await interviewModel.getCandidateInterviews(userId);
};

exports.confirmInterview = async (id) => {
  return await interviewModel.confirmInterview(id);
};

exports.cancelInterview = async (id) => {
  return await interviewModel.cancelInterview(id);
};

exports.scheduleInterview = async (id, date) => {
  return await interviewModel.scheduleInterview(id, date);
};