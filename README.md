# README
# Mumbai Customer API

A Ruby on Rails API that accepts a `customers.txt` file (JSON lines format), filters customers within **100 km of the Mumbai office** (`19.0590317, 72.7553452`), and returns their `user_id` and `name`, sorted by `user_id` ascending.

---

## Features

- Upload a `customers.txt` file (JSON lines format).
- Parse and validate each line as JSON.
- Calculate great-circle distance using the **spherical law of cosines**.
- Filter customers within **100 km** of Mumbai.
- Return a clean JSON response with `{ user_id, name }`.
- Organized code with service objects.
- Fully tested with RSpec.

---


##  Setup

### 1. Prerequisites
- Ruby 3.1+ (tested with 3.3)
- Rails 7.x
- Bundler
- Git

### 2. Install dependencies
    ```bash
    bundle install
### 3. Setup Rsepc
   rails generate rspec:install


### 4. Setup Rails
 rails server

----
 
## Usage
API Endpoint

POST /api/v1/customers/upload

Params:

file (required) — multipart/form-data, plain text file where each line is a JSON object.

Example customers.txt
{"user_id": 1, "name": "Vivaan Sharma", "latitude": "19.060", "longitude": "72.755"}
{"user_id": 2, "name": "Aditya Singh", "latitude": "82.784317", "longitude": "-11.291294"}


Example Request
curl -X POST "http://localhost:3000/api/v1/customers/upload" \
  -F "file=@customers.txt"

Example Response
[
  { "user_id": 1, "name": "Vivaan Sharma" },
  { "user_id": 3, "name": "Ayaan Reddy" }
]
