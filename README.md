# LOCO IP API

A simple RESTful api for managin

## Setup with Docker

### Build the application

    docker-compose build

### Setup & seed DB

    docker-compose run web rails db:setup

### Create `.env` file with

    IPSTACK_ACCESS_KEY=your-ipstack-key

### Start development server

    docker-compose up

### Run tests

    docker-compose run web bundle exec rspec
