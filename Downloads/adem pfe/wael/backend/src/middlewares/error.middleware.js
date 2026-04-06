module.exports = (err, req, res, next) => {
  console.error('[ERROR MIDDLEWARE]', {
    message: err.message,
    status: err.status || 500,
    path: req.path,
    method: req.method,
    stack: err.stack
  });

  // Don't override status if already set
  const status = err.status || err.statusCode || 500;
  
  res.status(status).json({ 
    error: err.message,
    message: err.message
  });
};