import app from './app';
import mongoose from 'mongoose';

require('dotenv').config();

//connect to mongoose server
mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('DB connection successful!'))
    .catch(err => console.log(err));




let port = process.env.PORT || 3000;

app.on('connection', () => {
    console.log('connected');
})

app.listen(port, () => {
    console.log('listening on port ' + port);
});

module.exports = app;