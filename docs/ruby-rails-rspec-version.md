# Ruby, Rails and RSpec Upgrade Documentation

## 1. Overview

This document describes the Ruby, Rails, and RSpec upgrades performed in the **Leitura** project.

The purpose of these upgrades was to modernize the application's dependencies, resolve compatibility issues, and prepare the project for future deployment on AWS.

The upgrades were performed incrementally to make troubleshooting easier and reduce the risk of introducing multiple breaking changes simultaneously.

### Technology Versions

| Technology | Previous Version | Updated Version |
|---|---|---|
| Ruby | 3.1.2 | 3.4.12 |
| Ruby on Rails | 7.0.4.3 | 7.2.3 |
| RSpec Rails | 4.0.2 | 7.1.1 |
| Puma | 5.6.5 | 6.6.1 |

### Upgrade Strategy

Rails was upgraded in two stages:

`Rails 7.0.4.3 → Rails 7.1.6 → Rails 7.2.3`

Each stage included dependency updates, configuration reviews, troubleshooting, and automated test execution.

---

## 2. Ruby Upgrade

### 2.1 Ruby 3.4.12

The application was updated to Ruby 3.4.12.

The Docker environment uses the Ruby 3.4 Bookworm image family:

```dockerfile
FROM ruby:3.4-bookworm
```

This image provides a Debian Bookworm-based environment for running the Ruby application.
The project uses the ruby:3.4-bookworm Docker image, which combines Ruby 3.4 with a Debian 12 (Bookworm) environment. This provides the operating system libraries and tools required by Ruby gems with native dependencies, such as pg and nokogiri. Debian Bookworm was selected to provide a consistent and compatible environment for the containerized Rails application.

### 2.2 Dependency Compatibility

During the Ruby environment update, dependency adjustments were required for gems including:

- `bundler`
- `bigdecimal`
- `nokogiri`
- `httparty`

These changes were necessary to resolve installation or compatibility issues encountered while preparing the updated environment.

The exact dependency constraints and individual error messages should be retrieved from the original Ruby upgrade changes before documenting them in greater detail.

### 2.3 Validation

Check the Ruby version:

```bash
docker compose exec web ruby -v
```

Expected version: Ruby 3.4.12.

Verify installed dependencies:

```bash
docker compose exec web bundle check
```

Rebuild the application when necessary:

```bash
docker compose up --build
```

---

## 3. Rails Upgrade

### 3.1 Rails 7.0.4.3 to 7.1.6

The first upgrade introduced changes to application configuration, exception handling, and test behavior.

#### Environment Configuration

Updated the application to use `config.enable_reloading` instead of the previous `config.cache_classes` setting.

Development:

```ruby
config.enable_reloading = true
```

Test and production:

```ruby
config.enable_reloading = false
```

Additional configuration changes included:

- Enabled verbose Active Job enqueue logging in development.
- Enabled missing controller callback action validation.
- Updated exception handling in the test environment.
- Preserved application-specific production logging settings.

#### Request Specification Changes

Rails 7.1 introduced changes affecting exception handling in request specifications.

The test environment was configured with:

```ruby
config.action_dispatch.show_exceptions = :rescuable
```

This required updating tests for missing records to expect an HTTP 404 response rather than an unhandled `ActiveRecord::RecordNotFound` exception.

The HTTP 422 status symbol was also updated:

```ruby
:unprocessable_content
```

This replaced the deprecated `:unprocessable_entity` symbol in the affected tests.

#### Active Storage Cleanup

Rails generated Active Storage migrations even though the application does not currently use Active Storage.

During the Rails 7.1 upgrade, the generated migrations were initially applied and subsequently rolled back.

The unused migration files and related schema migration records were cleaned up.

The database migration history was checked afterward.

#### Validation

After resolving the compatibility and configuration issues:

- Rails 7.1.6 was confirmed.
- The RSpec test suite passed.
- The GitHub Actions workflow was validated for the Rails 7.1 upgrade.

### 3.2 Rails 7.1.6 to 7.2.3

The second upgrade focused on updating Rails and its dependencies while preserving the existing application configuration.

#### Dependency Update

Updated the Rails version in the Gemfile and resolved dependencies using Bundler.

#### Rails Configuration Generator

Executed:

```bash
docker compose exec web bin/rails app:update
```

The generator proposed changes to several configuration files.

Instead of automatically overwriting existing files, each conflict was reviewed individually.

The objective was to preserve application-specific configuration while incorporating relevant changes introduced by Rails 7.2.

#### Application Configuration

Added the Rails library autoload configuration:

```ruby
config.autoload_lib(ignore: %w[assets tasks])
```

This configures Rails autoloading behavior for the `lib` directory while excluding the specified directories.

The existing `config.load_defaults` setting was preserved rather than automatically enabling all new framework defaults.

#### Framework Defaults

Rails generated:

```text
config/initializers/new_framework_defaults_7_2.rb
```

This file was retained to support the gradual adoption of Rails 7.2 defaults.

The new settings were reviewed instead of enabling all behavioral changes at once.

#### Parameter Filtering

Reviewed and updated:

```text
config/initializers/filter_parameter_logging.rb
```

The Rails 7.2 template introduced additional filtering recommendations, including email parameters.

The existing sensitive parameter filtering configuration was preserved.

#### Generated Files

The following generated files were retained:

```text
bin/brakeman
bin/rubocop
config/initializers/new_framework_defaults_7_2.rb
public/406-unsupported-browser.html
public/icon.png
public/icon.svg
```

The binstubs provide entry points for development tools, while the public files provide default Rails assets and an unsupported-browser error page.

#### Database Migrations

Rails 7.2 generated additional Active Storage migrations.

Since Active Storage is not currently used, the generated migrations were removed before being applied.

The database migration status was checked to confirm the application's expected migration history.

---

## 4. Compatibility Issues and Solutions

### 4.1 Puma and Rack Compatibility

**Problem**

After upgrading Rails to 7.1, the application server failed to start because the existing Puma 5.6.5 version was incompatible with the updated Rack environment.

**Solution**

Updated Puma to version 6.6.1.

This resolved the server compatibility issue.

**Additional issue**

A stale Rails server PID file prevented the server from starting during troubleshooting.

The issue was resolved by removing the existing `tmp/pids/server.pid` file.

**Result**

The application server started successfully.

### 4.2 Debug and Reline Compatibility

**Problem**

The `rails app:update` command failed during an interactive configuration conflict.

The error included:

```text
ArgumentError:
missing keyword: :encoding
```

The issue involved the installed versions of `debug` and `reline`.

**Solution**

Updated the `debug` dependency to version 1.11.1.

The configuration generator was then executed again.

**Result**

The `rails app:update` command completed successfully.

### 4.3 RSpec Rails Compatibility

**Problem**

After upgrading Rails to 7.2, the RSpec test suite failed while loading specifications.

The error included:

```text
NoMethodError:
undefined method `fixture_path'
```

The project was still using `rspec-rails 4.0.2`, which was incompatible with the updated Rails framework.

**Solution**

Updated the Gemfile:

```ruby
gem 'rspec-rails', '~> 7.1'
```

Then updated the dependency:

```bash
docker compose exec web bundle update rspec-rails
```

**Final versions**

- RSpec: 3.13
- RSpec Rails: 7.1.1

**Result**

The test suite loaded and executed successfully after the upgrade.

### 4.4 Rails Deprecation Warning

During the Rails 7.2 upgrade, the following warning was observed:

```text
ActiveSupport::ProxyObject is deprecated
and will be removed in Rails 8.0
```

This warning did not prevent the application from starting or the tests from executing.

The underlying dependency or configuration responsible for the warning has not yet been fully investigated.

It remains a future maintenance item.

---

## 5. Technical Decisions

### 5.1 Incremental Rails Upgrade

Rails was upgraded through intermediate versions rather than jumping directly from 7.0 to 7.2.

This allowed issues to be isolated and resolved at each stage.

### 5.2 Preserve Existing Configuration

During `rails app:update`, existing configuration files were not automatically replaced.

Instead, changes were reviewed manually to avoid losing custom settings.

### 5.3 Gradual Framework Defaults Adoption

New Rails defaults were not automatically enabled simply because the framework version changed.

This decision reduced the number of behavioral changes introduced during the dependency upgrade.

### 5.4 Remove Unused Active Storage Migrations

The application does not currently use Active Storage.

Generated migrations were removed to avoid introducing unnecessary database tables.

### 5.5 Keep Generated Rails Files

The Rails 7.2 binstubs and default public assets were retained.

They do not require immediate customization and may support future maintenance work.

---

## 6. Validation Commands and Results

### Check Ruby Version

```bash
docker compose exec web ruby -v
```

Expected: Ruby 3.4.12.

### Check Rails Version

```bash
docker compose exec web bin/rails -v
```

Expected:

```text
Rails 7.2.3
```

### Check RSpec Version

```bash
docker compose exec web bundle exec rspec --version
```

Expected: RSpec 3.13.

### Check RSpec Rails Version

```bash
docker compose exec web bundle info rspec-rails
```

Expected: `rspec-rails 7.1.1`.

### Check Puma Version

```bash
docker compose exec web bundle exec puma --version
```

Expected: Puma 6.6.1.

### Check Database Migrations

```bash
docker compose exec web bin/rails db:migrate:status
```

Verify that the required application migrations are applied and no unexpected migrations remain.

### Run Automated Tests

```bash
docker compose exec web bundle exec rspec
```

**Result:** All tests passed locally after resolving the upgrade-related compatibility issues.

### Start the Application

```bash
docker compose up --build
```

**Result:** The application started successfully and was manually verified in the browser.

### GitHub Actions

The Rails 7.1 upgrade was validated through GitHub Actions.

The Rails 7.2 upgrade still requires CI validation.

An existing intermittent request specification failure has been observed, particularly after merges into `main`.

This issue is being tracked separately.

---

## 7. Known Issues and Future Improvements

### Intermittent Request Specification Failure

An existing request specification occasionally fails in GitHub Actions.

The affected test checks whether book titles are displayed on the index page.

The failure has been observed after pushing or merging changes into `main`, while rerunning the workflow has sometimes succeeded.

The cause has not yet been confirmed.

The investigation will be handled in a separate task.

### Rails Framework Defaults

Review the currently configured `config.load_defaults` value and evaluate the adoption of newer framework defaults in a future maintenance task.

### Rails 8.0 Deprecation Warning

Investigate the `ActiveSupport::ProxyObject` deprecation warning before a future Rails 8.0 upgrade.

---

## 8. Lessons Learned

**Incremental upgrades reduce troubleshooting complexity.**

Updating Rails through intermediate versions made it easier to identify changes affecting dependencies, configuration, and tests.

**Framework upgrades affect the surrounding ecosystem.**

Updating Rails required reviewing Puma, Rack, RSpec Rails, and debugging dependencies.

**Generated configuration files should be reviewed carefully.**

The `rails app:update` command provides useful templates, but automatically replacing files can remove application-specific settings.

**Automated tests are essential during upgrades.**

RSpec helped identify changes in request handling and dependency compatibility.

**Passing tests locally does not guarantee CI stability.**

The existing intermittent request specification failure demonstrates the importance of investigating differences between local and CI execution.

**Documenting technical decisions improves maintainability.**

Recording not only what changed, but why it changed, creates a useful reference for future upgrades and troubleshooting.

---

## 9. Official Documentation

- [Ruby Documentation](https://docs.ruby-lang.org/)
- [Ruby on Rails Upgrade Guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html)
- [Rails 7.1 Release Notes](https://guides.rubyonrails.org/7_1_release_notes.html)
- [Rails 7.2 Release Notes](https://guides.rubyonrails.org/7_2_release_notes.html)
- [Rails Autoloading and Reloading](https://guides.rubyonrails.org/autoloading_and_reloading_constants.html)
- [RSpec Rails](https://github.com/rspec/rspec-rails)
- [RSpec Documentation](https://rspec.info/documentation/)
- [Bundler Documentation](https://bundler.io/docs.html)
- [Puma Documentation](https://github.com/puma/puma)
- [Docker Documentation](https://docs.docker.com/)
