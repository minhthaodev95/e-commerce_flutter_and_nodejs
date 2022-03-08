import mongoose from 'mongoose';

// create Category Schema mongoose models
const categorySchema = new mongoose.Schema({
    title: {
        type: String,
        index: { unique: true },
        required: true
    },
    description: {
        type: String,
        required: false
    },

})

const Category = mongoose.model('Category', categorySchema);



module.exports = Category;