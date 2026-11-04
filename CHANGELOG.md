# Changelog

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

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

- The README is plainer and has a licence section.
- The changelog entries are plainer.
- The release build writes the checksum file inside the build step.

## [1.0.1] - 2026-11-02

### Added

- Show the project address on Administration, Plugins.
- Match the name, author and version to the redmine.org listing, so "Check for updates" finds the plugin. The listing text is in `docs/redmine-org-listing.md`.

## [1.0.0] - 2026-11-01

First release. Redmine 7.0 and newer.

### Added

- A New issue button in front of the search box on every page, for a signed-in user who may add issues.
- Inside a project the button opens that project's form. Elsewhere it opens the global form.
- The label follows the user's language. The phone layout hides the button.
- A demo with made-up data (`ruby bin/demo up`), a browser check of the button and README screenshots.

### Fixed

- The label was white on white in Redmine's default theme, because the header's link colour won over the plugin's.

[1.0.0]: https://github.com/rubylode/redmine-rubylode-new-issue-button/releases/tag/v1.0.0
