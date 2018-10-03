'use strict';

let expect = require('chai').expect;
let chai = require('chai'),
    chaiHttp = require('chai-http');
chai.use(chaiHttp);
let request = require('request');

describe('do some test', function() {
    it('should be able to do a GET request and see some mocked content', function(done) {
        let options = {
            url: 'http://localhost:3000/fruits'
        };
        request.get(options.url, function(err, res) {
            expect(res.statusCode).to.equal(200);
            expect(res.body).contains("Apple");
            done();
        });
    });
});
