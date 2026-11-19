# CI/CD Implementation — Building Leitura

**Date:** November 2026  
**Project:** Building Leitura  
**Technologies:** GitHub Actions, Docker, Ruby on Rails, PostgreSQL, RSpec, Tailwind CSS

**Status:** Completed — CI pipeline working

## 1. Objective

Implement a Continuous Integration pipeline to automatically validate code changes before and after merging into the main branch.

The pipeline should:

- Build the Rails application using Docker.
- Configure a PostgreSQL test environment.
- Prepare the test database.
- Compile Tailwind CSS assets.
- Execute automated RSpec tests.
- Report failures through GitHub Actions.

## 2. Key Concepts Learned

### GitHub Actions

- **Workflow:** An automated process defined in a YAML file.
- **Event:** An action that triggers the workflow, such as `push` or `pull_request`.
- **Job:** A collection of steps executed on a runner.
- **Runner:** The environment responsible for executing jobs.
- **Step:** An individual action or command within a job.

**CI vs CD**

- Continuous Integration validates changes automatically.
- Continuous Delivery prepares validated changes for release.
- Continuous Deployment automatically releases validated changes.

### Docker and Docker Compose

- A Dockerfile defines how an image is built.
- An image contains the application environment and dependencies.
- A container is a running instance of an image.
- Docker Compose coordinates multiple services, such as Rails and PostgreSQL.
- `docker compose build` builds images.
- `docker compose run --rm` creates a temporary container to execute a command.
- `docker compose exec` runs a command inside an existing container.

**Important:** The Dockerfile's `CMD` can be overridden by the `command` defined in Docker Compose.

### Ruby and Dependencies

Updated Ruby from 3.1.2 to 3.4 using the `ruby:3.4-bookworm` Docker image.

**Lessons learned:**

- Bookworm refers to the Debian Linux distribution used as the image base.
- Updating Ruby does not automatically update Rails or other gems.
- The Gemfile defines dependency requirements.
- Gemfile.lock records the resolved dependency versions.
- Some gems require updates to remain compatible with newer Ruby versions.
- Bundler manages Ruby dependencies and their installation.

Encountered compatibility issues involving gems such as Nokogiri and Ruby standard-library components.

### PostgreSQL and Test Environment

- PostgreSQL runs as a separate Docker Compose service.
- Rails connects to the database using environment variables.
- GitHub Actions can provide configuration through variables and encrypted secrets.
- A job must reference the appropriate GitHub environment when using environment-scoped configuration.
- `rails db:prepare` prepares the database for the current Rails environment.
- Test data should be controlled by the tests rather than relying on development seeds.

### RSpec and Test Isolation

- RSpec executes automated tests and reports failures.
- FactoryBot creates controlled test records.
- Request specs validate HTTP responses and application behavior.
- Tests should not depend on unrelated database records.
- Intermittent failures can indicate shared state, ordering dependencies, or other nondeterministic behavior.

## 3. Problems Encountered

| Problem | Learning / Resolution |
|---|---|
| Docker image compatibility | Updated the Ruby base image |
| Bundler dependency errors | Reviewed and updated dependencies |
| Missing Ruby libraries | Resolved required gem dependencies |
| Database authentication failure | Corrected GitHub Actions environment configuration |
| Missing Tailwind CSS asset | Added the CSS build step |
| Unexpected test data | Prevented development seeds from populating the test database |
| Intermittent RSpec failure | Created a follow-up investigation task |

## 4. Useful Commands

**Build the application image**

```bash
docker compose build web
```

**Prepare the test database**

```bash
docker compose run --rm -e RAILS_ENV=test web bundle exec rails db:prepare
```

**Run RSpec**

```bash
docker compose run --rm -e RAILS_ENV=test web bundle exec rspec
```

**Inspect running containers**

```bash
docker ps
```

**Compare changes against main**

```bash
git diff main...HEAD
```

## 5. Technical Decisions

- Use Docker Compose in CI to reuse the project's container configuration.
- Use GitHub Actions to automate validation.
- Execute RSpec in the test environment.
- Keep sensitive configuration in GitHub Secrets.
- Avoid populating the test database with development seeds.
- Separate CI implementation from future AWS deployment automation.

## 6. Topics for Future Review

- [ ] Docker image layers and build caching
- [ ] Ruby standard library and default gems
- [ ] Bundler dependency resolution
- [ ] GitHub Actions caching and official actions
- [ ] Test isolation and intermittent failures
- [ ] CI pipeline optimization
- [ ] Continuous Delivery vs Continuous Deployment

## 7. References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Bundler Documentation](https://bundler.io/)
- [RSpec Documentation](https://rspec.info/)

## 8. Next Step

**AWS Deployment**

Deploy Building Leitura using Amazon ECR and Amazon ECS with AWS Fargate.

The goal is to understand the complete deployment process, from building the Docker image to running the application in AWS.
