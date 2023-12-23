import { User } from "../models/User.js";

const userController = {
  findAll: async (req, res) => {
    try {
      const users = await User.find();

      if (!users) res.status(404).json({message: "No users was found!"});

      res.json(users);
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while getting users.", errorMessage: error.message});
    }
  },

  // localhost:$$$$/users/:id
  findOne: async (req, res) => {
    const { id } = req.params;

    try {
      const user = await User.findById(id);

      if (!user) res.status(404).json({message: "User was not found!"});

      res.json(user);
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while getting the user.", errorMessage: error.message});
    }
  },

  // localhost:$$$$/users/:id
  delete: async (req, res) => {
    const { id } = req.params;

    try {
      const user = await User.findByIdAndDelete(id);

      if (!user) res.status(404).json({message: "User was not found!"});

      res.status(202).json({ status: "success", message: "User was deleted"});
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while getting the user.", errorMessage: error.message});
    }
  }
};

export default userController;
