import express from 'express';
import userController from '../../controllers/auth/user.controller';
import authController from '../../controllers/auth/auth.controller';
import multer from 'multer';
require('dotenv').config();

const router = express.Router();

//storage save avatar image



const upload = multer();


let userRoutes = (app) => {
    router.get('/me', authController.isAuthenticated, userController.getUser);
    router.put('/me', upload.single('files'), authController.isAuthenticated, userController.updateUser);
    router.delete('/me', authController.isAuthenticated, userController.deleteUser);
    router.get('/me/avatar/:filename', userController.getAvatar);
    //router change password
    router.put('/me/password', authController.isAuthenticated, userController.changePassword);
    // router forgot password
    router.post('/forgot', userController.forgotPassword);
    return app.use('/api/user', router);
}
module.exports = userRoutes;
/**
 * @swagger
 * /api/user/me:
 *     get:
 *        summary: Get user
 *        tags:
 *           - User
 * */
//update user routes
/**
 * @swagger
 * /api/user/me:
 *     put:
 *         summary: Update user by Id
 *         tags:
 *             - User
 * */

/**
 * @swagger
 * /api/user/me:
 *     delete:
 *         summary: Delete user byId
 *         tags:
 *             - User
 * */
//delete user routes
// stream image routes
/**
 * @swagger
 * /api/user/me/avatar/:filename:
 *     get:
 *         summary: Link stream image get from database
 *         tags:
 *             - User
 * */

/**
 * @swagger
 * /api/user/me/password:
 *      put:
 *          summary: Change password for user
 *          tags:
 *              - User
 * */


/**
 * @swagger
 * /api/user/forgot:
 *     post:
 *          summary: Send email to user to reset password
 *          tags:
 *              - User
 * */