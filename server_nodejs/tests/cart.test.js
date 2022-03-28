process.env.NODE_ENV = 'test';
import '@babel/polyfill';
let chai = require('chai');
let chaiHttp = require('chai-http');
let should = chai.should();
let server = require('../src/server');
let Product = require('../src/models/product.model');
let Cart = require('../src/models/cart.model');
let User = require('../src/models/user.model');



chai.use(chaiHttp);

//test add product to carts
describe('/POST add product to carts', () => {
    //create a new user and delete it
    it('it should POST add product to carts', (done) => {
        let product = new Product({
            title: 'product 01',
            price: 100,
            description: 'product 01',
            image: 'product01.jpg',
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID
        });
        product.save((err, product) => {
            if (err) {
                console.log(err);
            } else {
                // const { id } = product;
                let productToAdd = {
                    productId: product._id,
                    quantity: 1,
                    shop: product.user,
                };
                chai.request(server)
                    .post('/api/cart')
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .send(productToAdd)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('items');
                        res.body.data.items.should.be.a('array')
                        res.body.data.items.length.should.be.eql(1);
                        done();
                    });
            }
        });
    }).timeout(5000);
}).timeout(5000);


// get all Carts from user
describe('/GET all carts', () => {
    it('it should GET all carts', (done) => {
        chai.request(server)
            .get('/api/cart')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('items');
                res.body.data.items.should.be.a('array');
                res.body.data.items.length.should.be.eql(1);
                done();
            }).timeout(5000);
    }).timeout(5000);
});

//deleta caer by id cart
describe('/DELETE cart', () => {
    it('it should DELETE cart', (done) => {
        let product = new Product({
            title: 'product 02',
            price: 100,
            description: 'product 02',
            image: 'product02.jpg',
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID
        });
        product.save((err, product) => {
            if (err) {
                console.log(err);
            } else {
                // const { id } = product;
                let productToAdd = {
                    productId: product._id,
                    quantity: 1,
                    shop: product.user,
                };
                chai.request(server)
                    .post('/api/cart')
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .send(productToAdd)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('items');
                        res.body.data.items.should.be.a('array')
                        let cartId = { cartId: res.body.data._id };
                        chai.request(server)
                            .delete('/api/cart')
                            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                            .send(cartId)
                            .end((err, res) => {
                                res.should.have.status(200);
                                res.body.should.be.a('object');
                                res.body.should.have.property('data');
                                res.body.data.should.have.property('items');
                                res.body.data.items.should.be.a('array')
                                done();
                            }).timeout(5000);
                    });
            }
        });
    }).timeout(5000);
}).timeout(5000);

// update quantity product in cart by id
describe('/PUT update quantity product in cart by id', () => {
    it('it should PUT update quantity product in cart by id', (done) => {
        let product = new Product({
            title: 'product 03',
            price: 100,
            description: 'product 03',
            image: 'product03.jpg',
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID
        });
        product.save((err, product) => {
            if (err) {
                console.log(err);
            } else {
                // const { id } = product;
                let productToAdd = {
                    productId: product._id,
                    quantity: 1,
                    shop: product.user,
                };
                chai.request(server)
                    .post('/api/cart')
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .send(productToAdd)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('items');
                        res.body.data.items.should.be.a('array')
                        res.body.data.items.length.should.be.eql(1);
                        let productToUpdate = {
                            productId: product._id,
                            quantity: 2
                        };
                        chai.request(server)
                            .put('/api/cart')
                            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                            .send(productToUpdate)
                            .end((err, res) => {
                                res.should.have.status(200);
                                res.body.should.be.a('object');
                                res.body.should.have.property('data');
                                res.body.data.should.have.property('items');
                                res.body.data.items.should.be.a('array')
                                done();
                            }).timeout(5000);
                    });
            }
        });
    }).timeout(5000);
}).timeout(5000);


//delete product in cart by productId
describe('/DELETE product in cart by productId', () => {
    it('it should DELETE product in cart by productId', (done) => {
        let product = new Product({
            title: 'product 04',
            price: 100,
            description: 'product 04',
            image: 'product04.jpg',
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID
        });
        product.save((err, product) => {
            if (err) {
                console.log(err);
            } else {
                // const { id } = product;
                let productToAdd = {
                    productId: product._id,
                    quantity: 1,
                    shop: product.user,
                };
                chai.request(server)
                    .post('/api/cart')
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .send(productToAdd)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('items');
                        res.body.data.items.should.be.a('array')
                            // res.body.data.items.length.should.be.eql(1);

                        chai.request(server)
                            .delete('/api/cart/product/' + product._id)
                            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                            .end((err, res) => {
                                res.should.have.status(200);
                                res.body.should.be.a('object');
                                res.body.should.have.property('data');
                                res.body.data.should.have.property('items');
                                res.body.data.items.should.be.a('array')
                                done();
                            }).timeout(5000);
                    });
            }
        });
    }).timeout(5000);
}).timeout(5000);