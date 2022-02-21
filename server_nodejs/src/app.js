import express from 'express';
import bodyParser from 'body-parser';
import User from '../src/models/user.model';
import initApiRoutes from './routes/api/apiRoute';
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


module.exports = app;