const isAdminMiddleware = async (req, res, next) => {
  if (!req.user) {
    return res.status(401).json({ error: "Unauthorized. You need to login." });
  }
  if (req.user.role !== "Admin") {
    return res.status(403).json({ error: "Forbidden. You are not an admin." });
  }
  next();
};

const isUserMiddleware = async (req, res, next) => {
  if (!req.user) {
    return res.status(401).json({ error: "Unauthorized. You need to login." });
  }
  if (req.user.role !== "User") {
    return res.status(403).json({ error: "Forbidden. You are not a normal user." });
  }
  next();
};

const isNotUserMiddleware = async (req, res, next) => {
  if (!req.user) {
    return res.status(401).json({ error: "Unauthorized. You need to login." });
  }
  if (req.user.role === "User") {
    return res.status(403).json({ error: "Forbidden. You are not a manager nor an admin." });
  }
  next();
};

export { isAdminMiddleware, isUserMiddleware, isNotUserMiddleware };
