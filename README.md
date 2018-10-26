# aws-sam-local-demo

This setup is a demo for testing API's on your local machine or in a CI pipeline. 
The test can be run without deploying the API first.
It runs completely in isolation, with full control over your test data.  

(For now this project only runs on Linux or MacOS).

Before you start, first install:\
AWS CLI\
SAM-CLI\
Docker

To run the tests, simply type the following command in the terminal: make

If you want to run a specific method: make <method name\>