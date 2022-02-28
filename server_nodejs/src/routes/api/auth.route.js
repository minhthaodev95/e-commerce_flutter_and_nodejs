import express from 'express';
import authController from '../../controllers/auth/auth.controller';
const router = express.Router();

let authRoutes = (app) => {

    router.post('/register', authController.registerUser);
    // route login routes
    router.post('/login', authController.loginUser);

    return app.use('/api/user/auth', router);
}

module.exports = authRoutes;