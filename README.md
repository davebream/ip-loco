# IP Loco 🌐

[![CI](https://github.com/davebream/ip-loco/workflows/CI/badge.svg)](https://github.com/davebream/ip-loco/actions?query=workflow%3ACI+branch%3Amaster)
[![codecov](https://codecov.io/gh/davebream/ip-loco/branch/master/graph/badge.svg)](https://codecov.io/gh/davebream/ip-loco/branch/master)

A simple RESTful JSON API for managing IP/url addresses & their geolocation data

## Setup with Docker

### Clone the repo

    git clone git@github.com:davebream/ip-loco.git
    cd ip-loco

### Prepare `.env` file

    echo "IPSTACK_ACCESS_KEY=your-ipstack-key" > .env

### Build the application

    docker-compose build

### Setup & seed the DB

    docker-compose run web rails db:setup

### Start the development server

    docker-compose up

### Run specs

    docker-compose run web bundle exec rspec

## Endpoints

| Endpoint                        | Description                                                        |
| ------------------------------- | ------------------------------------------------------------------ |
| `GET /ip_addresses/:address`    | Retrieve a record                                                  |
| `DELETE /ip_addresses/:address` | Delete a record                                                    |
| `PUT /ip_addresses/:address`    | Create or update a record with new geolocation data (from ipstack) |

`:address` has to be a valid IPv4/IPv6 IP or url

## Initial data

Seeds include the following IPs/urls:

- http://airbnb.com
- http://medium.com
- 151.101.129.69
