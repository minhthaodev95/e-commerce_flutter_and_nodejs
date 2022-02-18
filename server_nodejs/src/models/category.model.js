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

const categorySchema = mongoose.model('Category', categorySchema);

module.exports = categorySchema;