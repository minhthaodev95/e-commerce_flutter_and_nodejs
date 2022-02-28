import express from 'express';
import bodyParser from 'body-parser';
import authRoutes from './routes/api/auth.route';
import productApi from './routes/api/product.route';
import categoryApi from './routes/api/category.route';
import userRoutes from './routes/api/user.route';
import cors from 'cors';
import configViewEngine from './config/viewEngine';
// const upload = multer();
const app = express();



// body parser setup
app.use(bodyParser.json());


app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors({
    origin: 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
}));

configViewEngine(app);
// app.use(upload.array());
// api routes
authRoutes(app);
productApi(app);
userRoutes(app);
categoryApi(app);


module.exports = app;