A basic recipe sharing application built with Rails 8, created primarily as a portfolio project to showcase some of the new Rails 8 features.

- Encryption with ActiveRecord

- Solid Queue for background jobs

- Solid Cache for async query loading

- Solid Cable for live updates

This app is not a full production build — it’s intentionally lean to highlight Rails 8’s modern stack.

---

## Features

![RSpec Tests](https://img.shields.io/badge/tests-passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-100%25-green)

1. User Management

- User registration, login, and logout.

- Profile page with basic info.

- Sensitive fields are encrypted with Rails 8 ActiveRecord Encryption.

2. Recipes

- Create, read, update, delete recipes.

- Each recipe has a title, description, instructions, prep/cook time.

- Recipe photos uploaded via Active Storage.

- Recipe photo background jobs processed with Solid Queue.

- Recipes can be categorized or tagged.

3. Ingredients

- Each recipe has many ingredients (name, quantity, unit).

- Ingredients load asynchronously when viewing recipes.

- Async queries are cached with Solid Cache.

4. Comments & Ratings

- Users can leave comments and ratings on recipes.

- Comments update live using Solid Cable (no page refresh).

---

## Testing

Due to current RSpec support issues with Rails 8 at the moment of the portfolio development, the test coverage is limited to:

- Unit tests

- Job tests

(Feature/system tests are not included yet.)

---

## Tech Stack

- **Ruby on Rails**
- **PostgreSQL**
- **Solid Cache**
- **Solid Cable**
- **Solid Queue**

---

## Setup Instructions

```bash
# Clone the repo
git clone git@github.com:anthony-devhub/recipe-sharing-app.git
cd recipe-sharing-app

# Install dependencies
bundle install
yarn install

# Setup DB
rails db:setup

# Run the server using foreman
foreman start -f Procfile.dev

```

## Author

**Anthony Salim**

Senior Ruby on Rails Backend Developer

🇮🇩 Indonesia | 🌐 Open to remote roles.

Let’s build something cool together!

📧 anthonysalim.dev@gmail.com