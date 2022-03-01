import express from 'express';
import authController from '../../controllers/auth/auth.controller';
import adminController from '../../controllers/auth/admin.controller';
require('dotenv').config();

const router = express.Router();

// get all users (just for admin)
router.get('/user', authController.isAdmin, adminController.getAllUsers);
// delete user by ID (just for admin)
router.delete('/user/:userId', authController.isAdmin, adminController.deleteUserById);
//get user by ID (just for admin)
router.get('/user/:userId', authController.isAdmin, adminController.getUserById);

//get user by email (just for admin)
router.get('/email/:email', authController.isAdmin, adminController.getUserByEmail);
//get users by role (just for admin)
router.get('/role/:role', authController.isAdmin, adminController.getUsersByRole);
// get users by username (just for admin)
router.get('/username/:username', authController.isAdmin, adminController.getUserByUsername);
//update role for user by userId (just for admin)
router.put('/user/:userId', authController.isAdmin, adminController.updateRoleForUser);



module.exports = router;


/**
 * @swagger
 * /api/admin/user:
 *   get:
 *    summary: Get all users (just for admin)
 *    tags:
 *    - Admin
 * */
/**
 * @swagger
 * /api/admin/user/:userId:
 *      delete:
 *          summary: Delete user by ID (just for admin)
 *          tags:
 *              - Admin
 * */
/**
 * @swagger
 * /api/admin/user/email/:email:
 *      get:
 *          summary: Get user by email (just for admin)
 *          tags:
 *              - Admin
 * */
/**
 * @swagger
 * /api/admin/user/role/:role:
 *      get:
 *          summary: Get user by role (just for admin)
 *          tags:
 *              - Admin
 * */
/**
 * @swagger
 * /api/admin/user/username/:username:
 *      get:
 *          summary: Get user by username (just for admin)
 *          tags:
 *              - Admin
 * */
/**
 * @swagger
 * /api/admin/user/:id:
 *      get:
 *          summary: Get user by ID (just for admin)
 *          tags:
 *              - Admin
 * */
/**
 * @swagger
 * /api/admin/user/:userId:
 *      put:
 *          summary: Update role for user by userId (just for admin)
 *          tags:
 *              - Admin
 * */