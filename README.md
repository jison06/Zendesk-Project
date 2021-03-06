# Zendesk Coding Project

## Requirements
- Ruby 2.7.5
- Nodejs Runtime at least v12.18.2
- Yarn at least 1.22.4
- master.key -- provided in my email. Please email me if you don't have this file. `jison0709@gmail.com`

## How to run
1. Once ruby is installed, ensure that the bundle gem is installed by running `gem install bundler` in your home directory
2. Clone the repo
3. From the command line go to the project directory
4. Run `bundle install` to install all gemfile dependencies
5. Run `yarn install` to install all javascript dependencies
6. Move `master.key` into the `config` folder to allow the server to decrypt the `credentials.yml.enc` file
7. Run `rails server` to start the development server
8. Once the server is running visit `http://localhost:3000`
9. You should see the list of tickets, be allowed to expand for details, and page through all available tickets

## How to test
1. From the command line go to the project directory
2. Run `bundle exec rspec spec` to run all the specs
3. You should see 6 passing tests

## Viewing ticket details
![1](https://user-images.githubusercontent.com/40171255/143780922-42e8e1e0-e2d8-4a3e-8bb2-360ba5e6d0a4.gif)

## Pagination
![2](https://user-images.githubusercontent.com/40171255/143780889-21fb7fc4-75b4-4749-a22b-606747aef7c0.gif)

## Browser History
![3](https://user-images.githubusercontent.com/40171255/143780967-db8ac342-7704-4d12-b968-dc6461e66d05.gif)
