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

let orderTestId;

// get all orders by userId
describe('/GET all orders', () => {
    it('it should GET all orders', (done) => {
        chai.request(server)
            .get('/api/order')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                res.body.data.length.should.be.eql(0);
                done();
            });
    }).timeout(5000);
});

// create an orders by list items in carts
describe('/POST create an orders', () => {
    //create a new user and delete it
    it('it should POST create an orders', (done) => {
        let product = new Product({
            title: 'product 012',
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
                    quantity: 3,
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
                        let items = {
                            items: res.body.data.items
                        }
                        chai.request(server)
                            .post('/api/order')
                            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                            .send(items)
                            .end((err, res) => {
                                res.should.have.status(200);
                                res.body.should.be.a('object');
                                res.body.should.have.property('data');
                                // res.body.data.should.have.property('items');
                                res.body.data.should.be.a('array')
                                    // res.body.data.items.length.should.be.eql(2);
                                orderTestId = res.body.data[0]._id;
                                done();
                            });
                    });
            }
        });
    }).timeout(5000);
}).timeout(5000);

// update status order by id
describe('/PUT update status order', () => {
    it('it should PUT update status order', (done) => {
        chai.request(server)
            .put('/api/order/' + orderTestId)
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send({ "status": 'processing' })
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('status');
                res.body.data.status.should.be.eql('processing');
                done();
            }).timeout(5000);
    }).timeout(5000);
});