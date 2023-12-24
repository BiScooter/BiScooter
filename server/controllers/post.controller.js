import mongoose from 'mongoose';
import { Post, postValidateSchema } from '../models/Post.js'

const postController = {
  // localhost:$$$/posts/create
  create: async (req, res) => {
    const authorId = new mongoose.Types.ObjectId(req.user._id);
    const { title, content } = req.body;

    // Validate the post structure
    const { error } = postValidateSchema.validate( req.body, { abortEarly: false });
    if (error) {
      return res.status(422).json(error.details);
    }

    try {
      // create the post
      const post = await Post.create({ title, content, authorId});

      res.status(201).json({ message: "Post created successfully", post });
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while creating your post. Please try again.", errorMessage: error.message });
    }
  },

  // localhost:$$$/posts/edit/:id
  edit: async (req, res) => {
    const { _id: authorID } = req.user;
    const { id } = req.params;
    const { title, content } = req.body;

    try {
      // Check if the post exists
      const post = await Post.findById(id);
      if (!post) return res.status(404).json({ status: "failed", message: "Post was not found!"});

      // check if the user is the author of the post
      if (!authorID.equals(post.authorId)) return res.status(403).json({ status: "failed", message: "Forbidden, you can't edit this post!"});

      // edit the post
      if(title) post.title = title;
      if(content) post.content = content;

      // save the changes to the database
      await post.save();

      res.json({status: "success", message: "Post updated successfully", post})
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while updating your post. Please try again.", errorMessage: error.message });
    }
  },

  // localhost:$$$/posts/
  findAll: async (req, res) => {
    const { _id: authorId, role } = req.user;

    try {
      // get all the user posts
      const posts = ( role === "User") ? await Post.find({ authorId }) : await Post.find();

      if(!posts)
        res.status(404).json({ message: "No posts found" });

      res.json(posts);
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while getting posts"});
    }
  },

  // localhost:$$$/posts/:id
  findOne: async (req, res) => {
    const { _id: authorId, role } = req.user;
    const { id } = req.params;
    
    try {
      const post = await Post.findById(id);

      // check if there is a post with this id
      if (!post) res.status(404).json({ status: "failed", message: "Post was not found!"});
      
      // check the user authority
      if (role === "User" && !authorId.equals(post.authorId)) return res.status(403).json({ status: "failed", message: "Forbidden, you can't see this post!"});
      
      res.json(post);
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while getting the post."});
    }
  },

  // localhost:$$$/posts/:id
  delete: async (req, res) => {
    const { id } = req.params;

    try {
      const post = await Post.findByIdAndDelete(id);
      
      if (!post) res.status(404).json({ status: "failed", message: "Post was not found!"});

      res.status(202).json({ status: "success", message: "Post deleted successfully."});
    } catch (error) {
      res.status(500).json({ status: "failed", message: "An error occurred while deleting the post.", errorMessage: error.message});
    }
  }
};

export default postController;
