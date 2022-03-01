import express from 'express';
import authController from '../../controllers/auth/auth.controller';
const router = express.Router();


let authRoutes = (app) => {

    /**
     * @swagger
     * /api/auth/login:
     *      post:
     *          summary: Login user
     *          tags:
     *             - Auth   
     */
    // route login routes
    router.post('/login', authController.loginUser);

    /**
     * @swagger
     * /api/auth/register:
     *     post:
     *         summary: Register user
     *         tags:
     *            - Auth     
     * */
    router.post('/register', authController.registerUser);

    return app.use('/api/auth', router);
}

module.exports = authRoutes;