import express from 'express';
import bodyParser from 'body-parser';
import authRoutes from './routes/api/auth.route';
import productApi from './routes/api/product.route';
import categoryApi from './routes/api/category.route';
import userRoutes from './routes/api/user.route';
import adminRoutes from './routes/api/admin.route';
import cartRoutes from './routes/api/cart.route';
import orderRoutes from './routes/api/order.route';
import authController from './controllers/auth/auth.controller';
import cors from 'cors';
import configViewEngine from './config/viewEngine';



// swagger UI
import swaggerUi from 'swagger-ui-express';
import swaggerJsDoc from 'swagger-jsdoc';

const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: 'E-commerce app API',
            description: 'A node app API for e-commerce',
            version: '1.0.0',
        },
        servers: [{
            url: 'http://localhost:3000',
        }],
    },
    customCss: '.swagger-ui .topbar { display: none }',
    apis: ['./src/routes/api/*.route.js']
}

const specs = swaggerJsDoc(options);

const app = express();

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));



// body parser setup
app.use(bodyParser.json());


app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors({
    origin: 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
}));



configViewEngine(app);

// api routes
app.use('/api/admin', authController.isAuthenticated, adminRoutes);
app.use('/api/cart', authController.isAuthenticated, cartRoutes);
app.use('/api/order', authController.isAuthenticated, orderRoutes);


authRoutes(app);
productApi(app);
userRoutes(app);
categoryApi(app);


module.exports = app;