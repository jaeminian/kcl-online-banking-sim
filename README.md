# Bank Jackal — Online Banking Simulation (Ruby on Rails)

A Ruby on Rails 6 web application that **simulates online banking** with separate **customer** and **admin** portals.  
Built as a **KCL 5CCS2SEG Software Engineering Group Project (Year 2)** to practice full-stack web development, authentication/authorization, data integrity, and automated testing.

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

Selected contributions (team project; I focused on authentication, authorization, and admin flows):

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

## Demo / Deployment

This repo is public for portfolio purposes.

**Deployed version (course instance / demo):**
- Customer: https://morning-dusk-01980.herokuapp.com/
- Admin: https://morning-dusk-01980.herokuapp.com/admin

> Note: The original course deployment may be offline depending on hosting availability.
> Demo accounts are for testing only and contain non-sensitive data.

### Role credentials (demo)

#### Client without 2-factor authentication
- username: `jackalfirst`
- password: `jackal1`

#### Client with 2-factor authentication
- username: `haewonjue`
- password: `haewonjue1`
- secondary password: `haewonjue2`

#### Admin User
- username: `superuser`
- password: `ABCdef.`

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
- `rails db:reset`  # dev/demo only (drops and recreates the database)

3) Run the server
- `rails server`

Then visit:
- Customer portal: `http://localhost:3000/`
- Admin portal: `http://localhost:3000/admin`

### Role credentials for Development Version

#### Personal Banking User
- username: `jack`
- password: `abcdef`

#### Admin User
- username: `admin`
- password: `abcdef`

---

## Test

Run the test suite:
- `rails test`

---

## Team (KCL Group Project)

- Ayan Ahmad
- Jae Min An
- Mihaela Peneva
- Kevin Quah
- Daniela Stanciu

---

## Credits / References

### Declarations
A significant amount of code ideas have been borrowed from the following:
1. https://www.linkedin.com/learning/ruby-on-rails-6-essential-training/faster-better-less-painful-website-development?u=76208058
2. https://hackernoon.com/building-a-simple-session-based-authentication-using-ruby-on-rails-9tah3y4j
3. https://github.kcl.ac.uk/stvb2117/hello_rails_v3/

### Front-end
- https://getbootstrap.com/
- https://mdbootstrap.com/
- https://jquery.com/
- https://datatables.net/
- https://www.amazon.in/LAORENTOU-Leather-Bifold-Vintage-Cowhide/dp/B077MTD5C7
- https://www.hiclipart.com/free-transparent-background-png-clipart-ztcdg
- https://unsplash.com
- https://fontawesome.com/
- https://images.freeimages.com
- https://stackoverflow.com/questions/41070556/how-can-i-prevent-duplicate-wrappers-on-a-jquery-datatable-when-navigating-back
- http://daneden.me/animate

### Backend (Ruby / Ruby on Rails)
- https://hackernoon.com/building-a-simple-session-based-authentication-using-ruby-on-rails-9tah3y4j
- http://www.refactoringrails.io/
- https://github.kcl.ac.uk/stvb2117/hello_rails_v3/
- https://www.rubyguides.com/2019/07/ruby-string-concatenation/
- https://stackoverflow.com/questions/16037597/ruby-array-checking-for-nil-array
- https://www.linkedin.com/learning/ruby-on-rails-6-essential-training/faster-better-less-painful-website-development?u=76208058
- https://www.rubydoc.info/github/codahale/bcrypt-ruby/BCrypt/Password#valid_hash%3F-class_method
- https://guides.rubyonrails.org/testing.html
- https://guides.rubyonrails.org/layouts_and_rendering.html
- https://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html
- https://guides.rubyonrails.org/active_record_validations.html
- https://rubygems.org/gems/activesupport/versions/5.2.4.4
- https://stackoverflow.com/questions/29101419/how-can-i-assert-two-different-values-for-two-different-objects-with-assert-dif
- https://justincypret.com/blog/activesupport-blank-vs-empty
- https://stackoverflow.com/questions/8258392/routes-in-rails-removing-actions-when-setting-up-a-resource

### Databases
- https://www.tutorialspoint.com/postgresql/postgresql_syntax.htm
- https://www.postgresqltutorial.com/psql-commands/
- https://stackoverflow.com/questions/769683/postgresql-show-tables-in-postgresql

### Git
- https://stackoverflow.com/questions/8965781/update-an-outdated-branch-against-master-in-a-git-repo
- https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet
- https://www.git-tower.com/blog/git-cheat-sheet/
