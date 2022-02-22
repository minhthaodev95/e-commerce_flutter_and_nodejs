import mongoose from 'mongoose';

// create Category Schema mongoose models
const categorySchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: false
    },

})

const Category = mongoose.model('Category', categorySchema);

// Category.create({
//     title: 'Category 1',
//     description: 'This is category 1'
// });

module.exports = Category;