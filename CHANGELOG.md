# Changelog

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [2.0.0] - 2026-11-04

Brings the plugin to the Rubylode plugin standard.

### Upgrading

- Run `bundle exec rake redmine:plugins:migrate RAILS_ENV=production` and restart Redmine, as for any upgrade.
- The plugin has no settings, so no key is renamed, there is no migration and there is nothing to move or reverse.
- If other code calls `RedmineRubylodeNewIssueButton::Hooks`, use `RubylodeNewIssueButton::Hooks`.

### Changed

- The Ruby module is `RubylodeNewIssueButton`, no longer `RedmineRubylodeNewIssueButton`.
- The README follows the standard headings: Install, Settings, Where it shows, Troubleshooting, Tests, License.
- The listing text and the roadmap describe the plugin as it is: no settings, and one button.

## [1.1.1] - 2026-11-04

### Changed

- Needs Redmine 5.1 or newer instead of 5.0. Redmine 5.0 cannot be tested in CI (the sqlite3 gem it pins does not build
  there), and this plugin only claims what CI verifies. No code changed.

## [1.1.0] - 2026-11-04

### Changed

- Runs on Redmine 5.0 and newer. The plugin's own tests pass unchanged on those versions; no code changed.

## [1.0.2] - 2026-11-03

### Added

- A Rubylode thumbnail at the top of the README.

### Changed

- The README is shorter and has a License section.
- Reworded the changelog entries.
- The release build writes the checksum file inside the build step.

## [1.0.1] - 2026-11-02

### Added

- The plugins page in Administration shows the project address.
- The plugin's name, author and version match the redmine.org listing, so "Check for updates" can find it. The listing text is in `docs/redmine-org-listing.md`.

## [1.0.0] - 2026-11-01

First release. Redmine 7.0 and newer.

### Added

- A New issue button in front of the search box on every page, for a signed-in user who may add issues.
- Inside a project the button opens that project's form. Elsewhere it opens the global form.
- The label follows the user's language. The phone layout hides the button.
- A demo with made-up data (`ruby bin/demo up`), a browser check of the button and README screenshots.

### Fixed

- The label was white on white in Redmine's default theme, because the header's link color won over the plugin's.

[2.0.0]: https://github.com/rubylode/redmine-rubylode-new-issue-button/compare/v1.1.1...v2.0.0
[1.0.0]: https://github.com/rubylode/redmine-rubylode-new-issue-button/releases/tag/v1.0.0
