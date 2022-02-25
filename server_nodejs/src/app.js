import express from 'express';
import bodyParser from 'body-parser';
import initApiRoutes from './routes/api/app.route';
import productApi from './routes/api/product.route';
import categoryApi from './routes/api/category.route';
import cors from 'cors';
import configViewEngine from './config/viewEngine';
// const upload = multer();
const app = express();



// body parser setup
app.use(bodyParser.json());


app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors({
    origin: '*'
}));


configViewEngine(app);
// app.use(upload.array());
// api routes
initApiRoutes(app);
productApi(app);
categoryApi(app);


module.exports = app;