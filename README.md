# README

Basic information:

Ruby: 2.5.1
Ruby on Rails: 5.2
Database: PostgreSQL
Storage: Amazon S3
Tests: Rspec
Deployment: Heroku
CI: Travis
Styles: Bootstrap


Setup:

rails db:migrate db:seed
rails s

After that, application is available on http://localhost:3000


Deployment:

Application is deployed on Heroku.
https://intense-meadow-89287.herokuapp.com/


Tests:

Unit tests are written with rspec gem.
To run all tests cases just:
rspec


CI:

Project is integrated with Travis CI, which inspect code with Rubocop and run every test case on each pullrequest.


Test

This README would normally document whatever steps are necessary to get the
application up and running.
