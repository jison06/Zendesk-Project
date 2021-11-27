# Zendesk Coding Project

## Requirements
- Ruby 2.6.5
- Nodejs Runtime at least v12.18.2

## How to run
1. Clone the repo
2. From the command line go to the project directory
3. Run `bundle install` to install all gemfile dependencies
4. Run `rails server` to start the development server
5. Once the server is running visit `http://localhost:3000`
6. You should see the list of tickets, be allowed to expand for details, and page through all available tickets

## How to test
1. From the command line go to the project directory
2. Run `bundle exec rspec spec` to run all the specs
3. You should see 6 passing tests
