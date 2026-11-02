# Changelog

All notable changes to this plugin. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-11-01

First release. Redmine 7.0 and newer.

### Added

- A New issue button in front of the search box on every page, for a signed-in user who may add issues.
- Inside a project it opens that project's form, elsewhere the global form.
- The label follows the user's language, and the button is hidden on the phone layout.
- A demo with made-up data (`ruby bin/demo up`), a browser check of the button and README screenshots.

### Fixed

- The button label was white on white in Redmine's default theme, because the header's link colour won over the plugin's.

[1.0.0]: https://github.com/rubylode/redmine-rubylode-new-issue-button/releases/tag/v1.0.0
