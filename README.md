# LOCO IP API

A simple RESTful api for managing ip addresses with geolocation data

## Setup with Docker

### Create `.env` file with

    IPSTACK_ACCESS_KEY=your-ipstack-key

### Build the application

    docker-compose build

### Setup & seed DB

    docker-compose run web rails db:setup

### Start development server

    docker-compose up

### Run tests

    docker-compose run web bundle exec rspec
