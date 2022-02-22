import express from 'express';
import bodyParser from 'body-parser';
import User from '../src/models/user.model';
import initApiRoutes from './routes/api/app.route';
import productApi from './routes/api/product.route';
import categoryApi from './routes/api/category.route';
import multer from 'multer';
import cors from 'cors';

const upload = multer();
const app = express();



// body parser setup
app.use(bodyParser.json());


app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors({
    origin: '*'
}));



app.use(upload.array());
// api routes
initApiRoutes(app);
productApi(app);
categoryApi(app);


module.exports = app;