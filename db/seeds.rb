# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ip_address_1 = IpAddress.find_or_initialize_by(address: 'airbnb.com')

ip_address_1.geolocation_data = {
  "ip": "35.168.232.115",
  "type": "ipv4",
  "continent_code": "NA",
  "continent_name": "North America",
  "country_code": "US",
  "country_name": "United States",
  "region_code": "VA",
  "region_name": "Virginia",
  "city": "Ashburn",
  "zip": "20147",
  "latitude": 39.043701171875,
  "longitude": -77.47419738769531,
  "location": {
    "geoname_id": 4744870,
    "capital": "Washington D.C.",
    "languages": [
      {
        "code": "en",
        "name": "English",
        "native": "English"
      }
    ],
    "country_flag": "http: //assets.ipstack.com/flags/us.svg",
    "country_flag_emoji": "🇺🇸",
    "country_flag_emoji_unicode": "U+1F1FA U+1F1F8",
    "calling_code": "1",
    "is_eu": false
  }
}

ip_address_1.save!

ip_address_2 = IpAddress.find_or_initialize_by(address: 'medium.com')

ip_address_2.geolocation_data = {
  "ip": "2606:4700::6810:7b7f",
  "type": "ipv6",
  "continent_code": "NA",
  "continent_name": "North America",
  "country_code": "US",
  "country_name": "United States",
  "region_code": "CA",
  "region_name": "California",
  "city": "San Francisco",
  "zip": "94107",
  "latitude": 37.775001525878906,
  "longitude": -122.41832733154297,
  "location": {
    "geoname_id": 5391959,
    "capital": "Washington D.C.",
    "languages": [
      {
        "code": "en",
        "name": "English",
        "native": "English"
      }
    ],
    "country_flag": "http://assets.ipstack.com/flags/us.svg",
    "country_flag_emoji": "🇺🇸",
    "country_flag_emoji_unicode": "U+1F1FA U+1F1F8",
    "calling_code": "1",
    "is_eu": false
  }
}

ip_address_2.save!

ip_address_3 = IpAddress.find_or_initialize_by(address: '151.101.129.69')

ip_address_3.geolocation_data = {
  "ip": "151.101.129.69",
  "type": "ipv4",
  "continent_code": "NA",
  "continent_name": "North America",
  "country_code": "US",
  "country_name": "United States",
  "region_code": "CA",
  "region_name": "California",
  "city": "San Francisco",
  "zip": "94107",
  "latitude": 37.76784896850586,
  "longitude": -122.39286041259766,
  "location": {
    "geoname_id": 5391959,
    "capital": "Washington D.C.",
    "languages": [
      {
        "code": "en",
        "name": "English",
        "native": "English"
      }
    ],
    "country_flag": "http://assets.ipstack.com/flags/us.svg",
    "country_flag_emoji": "🇺🇸",
    "country_flag_emoji_unicode": "U+1F1FA U+1F1F8",
    "calling_code": "1",
    "is_eu": false
  }
}

ip_address_3.save!
