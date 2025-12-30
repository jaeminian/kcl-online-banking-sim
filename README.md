# Bank Jackal — Online Banking Simulation (Ruby on Rails)

A Ruby on Rails 6 web application that **simulates online banking** with separate **customer** and **admin** portals.  
Built as a **KCL Year 2 group project** to practice full-stack web development, authentication/authorization, data integrity, and automated testing.

> ⚠️ Educational project: This is a simulation and does **not** process real financial data.

---

## Key Features

### Customer Portal
- User registration & login
- Account overview (multi-currency)
- Transaction history & transfers
- Optional **two-factor authentication (2FA)**

### Admin Portal
- Admin dashboard for managing the system
- CRUD for **Users**, **Accounts**, **Currencies**, **Transactions**
- Safety guardrails (e.g., prevent destructive actions when dependent records exist)
- Seed / generate realistic demo transactions for testing & demos

### Engineering
- Rails MVC architecture with model validations and controller guardrails
- Session helpers for consistent login state and redirects
- Integration tests covering core login flows (standard / admin / 2FA)

---

## My Contributions (Jaemin An)
- Implemented data validation & normalization for user credentials (e.g., case-insensitive email/username handling)
- Built a two-phase login flow with optional **2FA** (secondary factor hashed with BCrypt)
- Added session utilities and role checks (admin vs. standard user) to gate controller actions
- Enforced account integrity validations (e.g., sort code / account number formats)
- Implemented transaction listing and balance computation with access control
- Built guarded transfer creation (strong params + input validation)
- Implemented admin CRUD flows with protective constraints
- Added a random transaction generator for demo datasets
- Authored integration tests for standard / admin / 2FA login paths

---

## Tech Stack
- Ruby 2.7.x
- Rails 6.0.x
- PostgreSQL

---

## Local Setup

### Prerequisites
- Ruby 2.7.x
- Bundler
- PostgreSQL

### Install & Run

1) Install dependencies
- `bundle install`

2) Set up database
- `rails db:migrate`
- `rails db:reset`

3) Run the server
- `rails server`

Then visit:
- Customer portal: `http://localhost:3000/`
- Admin portal: `http://localhost:3000/admin`

---

## Demo / Deployment (Optional)

If you have a deployed instance, place the links here.

> Security note: If this repository is public, avoid committing secrets and avoid sharing real credentials.  
> Use demo-only accounts with non-sensitive data.

- Customer: `<DEPLOYED_URL>`
- Admin: `<DEPLOYED_URL>/admin`

---

## Test
Run the test suite:

- `rails test`

---

## Team (KCL Group Project)
- Ayan Ahmad (K19002255)
- Jae Min An (K19034574)
- Mihaela Peneva (K19026170)
- Kevin Quah (K1921877)
- Daniela Stanciu (K1922053)

---

## Credits / References
High-level references used during development:
- Ruby on Rails Guides (testing, validations, layouts)
- BCrypt documentation
- Various web development references used during the course
