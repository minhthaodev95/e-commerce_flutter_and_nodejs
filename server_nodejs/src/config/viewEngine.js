import express from 'express';

let configViewEngine = (app) => {
    app.use(express.static(path.join(__dirname, '../public')));
    app.set('views', path.join(__dirname, '../views'));
    app.set('view engine', 'ejs');
}