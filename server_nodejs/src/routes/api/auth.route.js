import express from 'express';
import authController from '../../controllers/auth/auth.controller';
const router = express.Router();


let authRoutes = (app) => {
    router.post('/login', authController.loginUser);
    router.post('/register', authController.registerUser);



    return app.use('/api/auth', router);
}

module.exports = authRoutes;

/**
 * @swagger
 * /api/auth/login:
 *      post:
 *          summary: Login user
 *          tags:
 *             - Auth   
 */
// route login routes

/**
 * @swagger
 * /api/auth/register:
 *     post:
 *         summary: Register user
 *         tags:
 *            - Auth     
 * */