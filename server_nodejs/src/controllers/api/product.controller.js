import Category from '../../models/category.model';
import Product from '../../models/product.model';
import User from '../../models/user.model';

module.exports = {
    getAllProduct: (req, res, next) => {
        Product.find({}).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting category',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getProductById: (req, res, next) => {

        Product.findById(req.params.id).populate('category').populate('user').exec((err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(product);
            }
        });
    },
    createProduct: (req, res, next) => {
        const product = new Product({
            title: req.body.title,
            description: req.body.description,
            price: req.body.price,
            category: req.body.category,
            user: req.body.user,
            image: req.body.image,
            list_image: req.body.list_image
        });
        product.save((err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when creating product',
                    error: err
                });
            } else {
                res.status(201).json(product);
            }
        });
    },
    updateProduct: (req, res, next) => {
        Product.findByIdAndUpdate(req.params.id, {
            $set: req.body
        }, (err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when updating product',
                    error: err
                });
            } else {
                res.status(200).json(product);
            }
        });
    },
    deleteProduct: (req, res, next) => {
        Product.findByIdAndRemove(req.params.id, (err, product) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when deleting product',
                    error: err
                });
            } else {
                res.status(200).json({
                    message: 'Delete product success'
                });
            }
        });
    },
    getProductByCategory: (req, res, next) => {
        Product.find({
            category: req.params.id
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getProductByUser: (req, res, next) => {
        Product.find({
            user: req.params.user
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getProductByTitle: (req, res, next) => {
        Product.find({
            title: req.params.title
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
    getProductByPrice: (req, res, next) => {
        Product.find({
            price: req.params.price
        }).populate('category').populate('user').exec((err, products) => {
            if (err) {
                console.error(err);
                res.status(500).json({
                    message: 'Error when getting product',
                    error: err
                });
            } else {
                res.status(200).json(products);
            }
        });
    },
}