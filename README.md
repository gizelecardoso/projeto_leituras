# 📚 Leitura — Reading Tracker

Leitura is a web application built with Ruby on Rails to help users organize and track their reading journey.

The project provides a simple way to manage a personal book collection and is being developed incrementally, with a focus on maintainable code, automated testing, and modern backend development practices.

## 🛠️ Tech Stack

**Backend**
- Ruby on Rails
- Ruby
- PostgreSQL

**Frontend**
- Hotwire / Turbo
- Tailwind CSS

**Development & Testing**
- Docker & Docker Compose
- RSpec
- FactoryBot & Faker
- Shoulda Matchers
- SimpleCov

## ✨ Features

The first MVP focuses on book management.

- Create new book records.
- View a list of registered books.
- View individual book details.
- Update existing book information.
- Delete books from the collection.
- Validate required book attributes.

Each book includes basic information such as its title, author, and number of pages.

## 🚀 Getting Started

### Pre-requisites

Make sure the following tools are installed:

- Docker
- Docker Compose
- Git

### Installation

**1. Clone the repository**

```bash
git clone git@github.com:gizelecardoso/projeto_leituras.git
cd leitura
```

**2. Build and start the application**

```bash
docker compose up --build
```

**3. Prepare the database**

```bash
docker compose exec web bin/rails db:prepare
```

**4. Access the application**

Open your browser and navigate to:

http://localhost:3000

> Note: Commands assume the Rails service is named `web` in Docker Compose. Adjust the service name and port according to the project configuration.

## 🧪 Testing

Leitura uses RSpec for automated testing.

The test suite includes model specifications and request specifications to verify application behavior.

### Running tests

```bash
docker compose exec web bundle exec rspec
```

### Test coverage

SimpleCov is used to monitor code coverage and identify areas that may require additional tests.

After running the test suite, the coverage report can be found at:

```text
coverage/index.html
```

## ⚙️ Technical Decisions

### Containerized development

Docker and Docker Compose are used to provide a consistent development environment and manage the application and PostgreSQL services.

### Automated testing

RSpec is used to verify application behavior, supported by FactoryBot for test data creation and Faker for generating realistic sample values.

### Database

PostgreSQL is used as the relational database, with Active Record handling data persistence and validations.

## 🗺️ Roadmap

Planned improvements include:

- [ ] Complete the first MVP and its automated tests.
- [ ] Implement continuous integration with GitHub Actions.
- [ ] Expand reading-tracking functionality.
- [ ] Add user authentication.
- [ ] Document the application architecture.
- [ ] Deploy the application to AWS.

## 📄 Project Status

**In active development — First MVP**

The application is currently being developed and improved incrementally.
