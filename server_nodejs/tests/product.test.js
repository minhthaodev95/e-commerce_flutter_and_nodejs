//During the test the env variable is set to test
process.env.NODE_ENV = 'test';
let Product = require("../src/models/product.model");
import '@babel/polyfill';
let chai = require('chai');
let chaiHttp = require('chai-http');
let server = require('../src/server');



chai.use(chaiHttp);




//test GET routes with no products in the database
describe('/GET products', () => {
    it('it should GET all the products', (done) => {
        chai.request(server)
            .get('/api/products')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                done();
            });
    }).timeout(5000);
});

// test POST a product  with authorization
describe('/POST product', () => {
    it('it should POST a product', (done) => {
        let product = {
            title: "Test Product",
            description: "Test Description",
            price: 10.00,
            category: "621c8b6b17c7fba318bf1924",
            tags: ["Test Tag"],
            images: ["Test Image"]
        }
        chai.request(server)
            .post('/api/product')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(product)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.be.have.property('data');
                res.body.data.should.be.a('object');
                res.body.data.should.have.property('title');
                res.body.data.should.have.property('description');
                res.body.data.should.have.property('price');
                res.body.data.should.have.property('category');
                res.body.data.should.have.property('tags');
                res.body.data.should.have.property('images');
                res.body.data.should.have.property('_id');
                res.body.data.should.have.property('user');

                done();
            }).timeout(5000);
    }).timeout(5000);



});


// test GET products by category
describe('/GET products by category', () => {
    it('it should GET all the products by category', (done) => {
        chai.request(server)
            .get('/api/products/category/621c8b6b17c7fba318bf1924')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                done();
            }).timeout(5000);
    }).timeout(5000);
});

//test GET a prodcut bu ID
describe('/GET product by id', () => {
    it('it should GET a product by id', (done) => {
        let product = new Product({
            title: "Test Product 1",
            description: "Test Description asdasd",
            price: 10.00,
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID,
            tags: ["Test Tag"],
            images: ["Test Image"]
        });
        product.save((err, product) => {
            if (err) return done(err);
            const { _id } = product;
            chai.request(server)
                .get('/api/product/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .send(product)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.be.have.property('data');
                    res.body.data.should.be.a('object');
                    res.body.data.should.have.property('title');
                    res.body.data.should.have.property('description');
                    res.body.data.should.have.property('price');
                    res.body.data.should.have.property('category');
                    res.body.data.should.have.property('tags');
                    res.body.data.should.have.property('images');
                    res.body.data.should.have.property('user');
                    res.body.data.should.have.property('_id').eql(_id.toString());
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
});


// test GET all products by userId
describe('/GET products by userId', () => {
    it('it should GET all the products by userId', (done) => {
        chai.request(server)
            .get('/api/products/user/' + process.env.USER_ID)
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                done();
            }).timeout(5000);
    }).timeout(5000);
});

// test PUT a product by id
describe('/PUT product by id', () => {
    it('it should UPDATE a product by id', (done) => {
        let product = new Product({
            title: "Test Product 1",
            description: "Test Description asdasd",
            price: 10.00,
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID,
            tags: ["Test Tag"],
            images: ["Test Image"]
        });
        product.save((err, product) => {
            if (err) return done(err);
            const { _id } = product;
            chai.request(server)
                .put('/api/product/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .send({
                    title: "Test Product 1",
                    description: "Test Description asdasd",
                    price: 10.00,
                    category: "621c8b6b17c7fba318bf1924",
                    user: process.env.USER_ID,
                    tags: ["Test Tag"],
                    images: ["Test Image"]
                })
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.be.have.property('data');
                    res.body.data.should.be.a('object');
                    res.body.data.should.have.property('title');
                    res.body.data.should.have.property('description');
                    res.body.data.should.have.property('price');
                    res.body.data.should.have.property('category');
                    res.body.data.should.have.property('tags');
                    res.body.data.should.have.property('images');
                    res.body.data.should.have.property('user');
                    res.body.data.should.have.property('_id').eql(_id.toString());
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
});

// test GET products by tags
describe('/GET products by tags', () => {
    it('it should GET all the products by tags', (done) => {
        chai.request(server)
            .get('/api/products/tags/Test Tag')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                done();
            }).timeout(5000);
    }).timeout(5000);
});

// test GET products by names
describe('/GET products by names', () => {
    it('it should GET all the products by names', (done) => {
        chai.request(server)
            .get('/api/products/name/Test Product 1')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');

                done();
            }).timeout(5000);
    }).timeout(5000);
});

// test GET products by range price
describe('/GET products by range price', () => {
    it('it should GET all the products by range price', (done) => {
        chai.request(server)
            .get('/api/products/price/10/20')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                done();
            }).timeout(5000);
    }).timeout(5000);
});

//test GET products by range Date
describe('/GET products by range Date', () => {
    it('it should GET all the products by range Date', (done) => {
        chai.request(server)
            .get('/api/products/date/2019-01-01/2019-01-02')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');

                done();
            }).timeout(5000);
    }).timeout(5000);
});

// test DELETE a product by id
describe('/DELETE product by id', () => {
    it('it should DELETE a product by id', (done) => {
        let product = new Product({
            title: "Test Product 1",
            description: "Test Description asdasd",
            price: 10.00,
            category: "621c8b6b17c7fba318bf1924",
            user: process.env.USER_ID,
            tags: ["Test Tag"],
            images: ["Test Image"]
        });
        product.save((err, product) => {
            if (err) return done(err);
            const { _id } = product;
            chai.request(server)
                .delete('/api/product/' + _id)
                .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                .end((err, res) => {
                    res.should.have.status(200);
                    res.body.should.be.a('object');
                    res.body.should.have.property('data');
                    res.body.data.should.have.property('title');
                    res.body.data.should.have.property('description');
                    res.body.data.should.have.property('price');
                    res.body.data.should.have.property('category');
                    res.body.data.should.have.property('images');
                    res.body.data.should.have.property('tags');
                    res.body.data.should.have.property('user');
                    res.body.data.should.have.property('_id').eql(_id.toString());
                    done();
                }).timeout(5000);
        });
    }).timeout(5000);
});