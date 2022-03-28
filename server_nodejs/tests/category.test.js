process.env.NODE_ENV = 'test';
import '@babel/polyfill';
let chai = require('chai');
let chaiHttp = require('chai-http');
let should = chai.should();
let server = require('../src/server');

chai.use(chaiHttp);


// test GET categories 
describe('/GET categories', () => {
    it('it should GET categories', (done) => {
        chai.request(server)
            .get('/api/category')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.be.a('array');
                // res.body.data.length.should.be.eql(0);
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);

// test CREATE a category
describe('/POST category', () => {
    it('it should POST a category', (done) => {
        let category = {
            title: "Test Category",
            description: "Test Description"
        };
        chai.request(server)
            .post('/api/category')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(category)
            .end((err, res) => {
                res.should.have.status(201);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('title');
                res.body.data.should.have.property('description');
                res.body.data.should.have.property('_id');
                done();
            }).timeout(5000);
    }).timeout(5000);
});


// UPDATE a category by ID
describe('/PUT category', () => {
    it('it should UPDATE a category', (done) => {
        let category = {
            title: "Test Category 1",
            description: "Test Description"
        };
        chai.request(server)
            .post('/api/category')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(category)
            .end((err, res) => {
                res.should.have.status(201);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('title');
                res.body.data.should.have.property('description');
                res.body.data.should.have.property('_id');
                let id = res.body.data._id;
                let categoryUpdate = {
                    title: "Test Category Update",
                    description: "Test Description Update"
                };
                chai.request(server)
                    .put('/api/category/' + id)
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .send(categoryUpdate)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('title');
                        res.body.data.should.have.property('description');
                        res.body.data.should.have.property('_id');
                        done();
                    }).timeout(5000);
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);

// DELETE a category by ID (Just admin can)
describe('/DELETE category', () => {
    it('it should DELETE a category', (done) => {
        let category = {
            title: "Test Category 2",
            description: "Test Description"
        };
        chai.request(server)
            .post('/api/category')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(category)
            .end((err, res) => {
                res.should.have.status(201);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('title');
                res.body.data.should.have.property('description');
                res.body.data.should.have.property('_id');
                let id = res.body.data._id;
                chai.request(server)
                    .delete('/api/category/' + id)
                    .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
                    .end((err, res) => {
                        res.should.have.status(200);
                        res.body.should.be.a('object');
                        res.body.should.have.property('data');
                        res.body.data.should.have.property('title');
                        res.body.data.should.have.property('description');
                        res.body.data.should.have.property('_id');
                        done();
                    }).timeout(5000);
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);