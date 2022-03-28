//During the test the env variable is set to test
process.env.NODE_ENV = 'test';

import '@babel/polyfill';
let chaiHttp = require('chai-http');
let chai = require('chai');
let server = require('../src/server');
let should = chai.should();


chai.use(chaiHttp);


//test GET user
describe('/GET user', () => {
    it('it should GET user', (done) => {
        chai.request(server)
            .get('/api/user/me')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('name');
                res.body.data.should.have.property('email');
                res.body.data.should.have.property('phone');
                res.body.data.should.have.property('address');
                res.body.data.should.have.property('role');
                res.body.data.should.have.property('id');
                done();
            });
    }).timeout(5000);
});

// test UPDATE user profile
describe('/PUT user', () => {
    it('it should UPDATE user profile', (done) => {
        let user = {
            name: "ShopOwner Updated",
            email: "demo@gmail.com",
            phone: "1234567890",
            address: "Test Address"
        }
        chai.request(server)
            .put('/api/user/me')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(user)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('data');
                res.body.data.should.have.property('name');
                res.body.data.should.have.property('email');
                res.body.data.should.have.property('phone');
                res.body.data.should.have.property('address');
                res.body.data.should.have.property('role');
                res.body.data.should.have.property('id');
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);


//test UPDATE password user 
describe('/PUT user', () => {
    it('it should UPDATE password user', (done) => {
        let info = {
            oldPassword: "123456",
            newPassword: "Test Password"
        }
        chai.request(server)
            .put('/api/user/me/password')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .send(info)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('message');
                res.body.should.have.property('status');
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);

//forget password user
describe('/POST user', () => {
    it('it should forget password user', (done) => {
        let info = {
            email: "demo@gmail.com"
        }
        chai.request(server)
            .post('/api/user/forgot-password')
            .send(info)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('message');
                res.body.should.have.property('status');
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);


// test DELETE user by ID from the database
describe('/DELETE user', () => {
    it('it should DELETE user by ID from the database', (done) => {
        chai.request(server)
            .delete('/api/user/me')
            .set("Authorization", "Bearer " + process.env.BEARER_TOKEN)
            .end((err, res) => {
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property('message');
                res.body.should.have.property('status');
                done();
            }).timeout(5000);
    }).timeout(5000);
}).timeout(5000);