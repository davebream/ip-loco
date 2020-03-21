# IP Loco

A simple RESTful JSON API for managing ip/url addresses & their geolocation data

## Setup with Docker

### Clone the repo

    git clone git@github.com:davebream/ip-loco.git
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

## Endpoints

| Endpoint                        | Description                                                             |
| ------------------------------- | ----------------------------------------------------------------------- |
| `GET /ip_addresses/:address`    | Retrieve record by the given address                                    |
| `DELETE /ip_addresses/:address` | Delete record with the given address                                    |
| `PUT /ip_addresses/:address`    | Create or update record with new geolocation data for the given address |

`:address` has to be a valid IPv4/IPv6 IP or url

## Seed data

The db is seeded with some urls/ips:

- http://airbnb.com
- http://medium.com
- 151.101.129.69
