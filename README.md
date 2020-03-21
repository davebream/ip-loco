# LOCO IP API

A simple RESTful api for managing ip addresses with geolocation data

## Setup with Docker

### Clone the repo

    git clone git@github.com:davebream/loco-ip-api.git
    cd loco-ip-api

### Prepare `.env` file

    echo "IPSTACK_ACCESS_KEY=your-ipstack-key" > .env

### Build the application

    docker-compose build

### Setup & seed DB

    docker-compose run web rails db:setup

### Start development server

    docker-compose up

### Run tests

    docker-compose run web bundle exec rspec
