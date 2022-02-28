import mongoose from 'mongoose';

const ProductSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: false
    },
    price: {
        type: Number,
        index: true,
        required: true
    },
    category: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Category',
        required: true
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    featureImage: {
        type: String,
        required: false
    },
    images: [{
        type: String,
        required: false
    }],
    created_at: {
        type: Date,
        default: Date.now
    },
    numberLiked: {
        type: Number,
        default: 0
    },
    numberViewed: {
        type: Number,
        default: 0
    },
    updated_at: {
        type: Date,
        default: Date.now
    }
});

const Product = mongoose.model('Product', ProductSchema);

// Product.create({
//     title: 'Product 1',
//     description: 'This is product 1',
//     price: 100,
//     category: '6214544dfb5746fa1653043e',
//     user: '620b57815eb5e0b588f2f7b9',
//     image: 'https://cdn.pixabay.com/photo/2016/11/29/05/47/milk-1867468_960_720.jpg',
//     list_image: [
//         'https://cdn.pixabay.com/photo/2016/11/29/05/47/milk-1867468_960_720.jpg',
//         'https://cdn.pixabay.com/photo/2016/11/29/05/47/milk-1867468_960_720.jpg',
//         'https://cdn.pixabay.com/photo/2016/11/29/05/47/milk-1867468_960_720.jpg'

//     ],
//     created_at: Date.now(),
//     numberLiked: 0,
//     numberViewed: 0,
//     updated_at: Date.now()
// });



module.exports = Product;