# Rubylode New issue button for Redmine

<p><img src="docs/thumbnail.png" alt="Rubylode New issue button plugin" width="160"></p>

[![tests](https://img.shields.io/github/actions/workflow/status/rubylode/redmine-rubylode-new-issue-button/tests.yml?branch=main&label=tests)](https://github.com/rubylode/redmine-rubylode-new-issue-button/actions/workflows/tests.yml)
[![security](https://img.shields.io/github/actions/workflow/status/rubylode/redmine-rubylode-new-issue-button/security.yml?branch=main&label=security)](https://github.com/rubylode/redmine-rubylode-new-issue-button/actions/workflows/security.yml)
[![version](https://img.shields.io/github/v/tag/rubylode/redmine-rubylode-new-issue-button?sort=semver&label=version)](https://github.com/rubylode/redmine-rubylode-new-issue-button/tags)
[![license](https://img.shields.io/github/license/rubylode/redmine-rubylode-new-issue-button)](https://github.com/rubylode/redmine-rubylode-new-issue-button/blob/main/LICENSE)
![Redmine](https://img.shields.io/badge/Redmine-5.1%20%7C%206.0%20%7C%206.1%20%7C%207.0-b22222)
![Ruby](https://img.shields.io/badge/Ruby-3.2%20%7C%203.3%20%7C%203.4%20%7C%204.0-cc342d)

TL;DR: a New issue button in front of the search box on every [Redmine](https://www.redmine.org) page.

Redmine lets you start a ticket only inside a project (the "+" menu). The global issue list, My page, Activity and the
administration pages have no such link. This plugin adds one button that works on every page.

Inside a project:

![The New issue button in the header of a project](docs/screenshots/button-in-project.png)

On any other page:

![The New issue button in the header of the global issue list](docs/screenshots/button-outside-project.png)

Contents:

- [Install](#install)
- [Settings](#settings)
- [Where it shows](#where-it-shows)
- [Troubleshooting](#troubleshooting)
- [Tests](#tests)
- [License](#license)

## Install

1. Put the plugin folder in Redmine's `plugins/` directory, named `redmine_rubylode_new_issue_button`.

       cd /path/to/redmine/plugins
       git clone https://github.com/rubylode/redmine-rubylode-new-issue-button.git redmine_rubylode_new_issue_button

   Or unpack a [release archive](https://github.com/rubylode/redmine-rubylode-new-issue-button/releases) there.

2. Run `bundle exec rake redmine:plugins:migrate RAILS_ENV=production`.
3. If the plugin reads an environment variable, set it where Redmine runs, then restart Redmine. This plugin reads none; restart Redmine anyway so it loads the plugin.
4. In Administration, Plugins, open the plugin and choose Configure.

Redmine 5.1 or newer. The plugin adds no table, gem or JavaScript library. With [Docker](https://www.docker.com), mount
or copy the plugin to `/usr/src/redmine/plugins/redmine_rubylode_new_issue_button` and restart the container.

To upgrade, `git pull`, run step 2 and restart. To remove it, delete the folder and restart.

## Settings

The plugin has no settings, so Configure in step 4 has nothing to show. Who sees the button follows Redmine's own
permissions: a signed-in user who may add issues sees it, with the label in the user's language. Nobody else does.

## Where it shows

- On every page, for a signed-in user who may add issues.
- Inside a project the button opens that project's new issue form. Anywhere else it opens the global form, which asks
  for the project.
- It sits as the first thing in the search box area, or first in the header on a page that has no search box.
- The phone layout hides it, because Redmine's own phone menu has the link.

`lib/rubylode_new_issue_button/hooks.rb` adds the stylesheet to the page head and, at the end of the body, a
script tag that carries the address and the label as `data-href` and `data-label`.
`assets/javascripts/rubylode_new_issue_button.js` inserts the link as the first child of `#quick-search` (or of
`#header` when a page has no search box). The script sits after the header in the page, so the button should be there
on first paint.

### Styling

The button is one link, `a.rubylode-new-issue-button`, inside `#quick-search` (or directly inside `#header` on a page
without a search box). That is the only class the plugin adds.

The plugin's stylesheet makes a plain white button that suits Redmine's default theme. Every rule starts with `#header`,
because the header colors its links white and an unprefixed rule loses to that.

A theme overrides it with its own stylesheet. Redmine loads plugin stylesheets after the theme's, in alphabetical order,
so when two rules have the same specificity the plugin's wins. Put `body` in front to give the theme's rule more weight
than the plugin's `#header a.rubylode-new-issue-button`:

    body #header a.rubylode-new-issue-button {
      background: #d33f49;
      border-color: #d33f49;
      color: #fff;
    }
    body #header a.rubylode-new-issue-button:hover { background: #b6323b; color: #fff; }

Without `#header` and `body` the plugin's rule wins and your change seems to do nothing. Avoid `!important`. To hide the
button on a layout, set `display: none` the same way.

## Troubleshooting

- **No button.** Sign in. A signed-out visitor never gets one, and neither does a user who may not add issues anywhere.
- **The button is missing on a phone.** The phone layout hides it on purpose.
- **A style change seems to do nothing.** See [Styling](#styling): start the rule with `body #header`.

Tested in CI on Redmine 7.0, 6.1, 6.0 and 5.1. Older versions are not supported.

## Tests

    bin/test                                              all integration tests
    bin/test test/integration/new_issue_button_test.rb    one file

They run in a Redmine 7 image with its test gems (`docker/test.Dockerfile`) and check the page a browser would get: the
form a member is sent to inside a project, the global form outside one, no button for a signed-out visitor, and the
assets in place.

Pull Requests are welcome!

### Try it

A throwaway Redmine 7 runs from this folder, with the repository mounted as the plugin:

    ruby bin/demo up
    open http://localhost:3011

The first start loads made-up demo data: three private projects and three people. Sign in as `admin` / `admin`,
as `dana` (may add issues in Orchard and Lighthouse only) or as `sam` (may not add issues anywhere), both with the
password `demo-password-1`. `docker compose up -d` alone starts a bare Redmine. Stop the demo with `ruby bin/demo down`
and wipe it with `ruby bin/demo reset`.

With Node and Chrome installed, run `npm install` once, then `npm run check` tests the button in the running demo and
`npm run screenshots` retakes the pictures above.

### Releasing

Push a `vX.Y.Z` tag whose version matches `version` in `init.rb` and has an entry in `CHANGELOG.md`. CI runs the tests, builds `redmine_rubylode_new_issue_button-X.Y.Z.zip` and publishes the GitHub release with the changelog entry as its notes. To build a release for a tag that already exists, use Actions, release, Run workflow.

The text for the www.redmine.org listing, and how to read the result of Check for updates, is in [docs/redmine-org-listing.md](docs/redmine-org-listing.md).

## License

GNU General Public License, version 2 or (at your option) any later version, the same as Redmine. See `LICENSE`.

Copyright (C) 2026  Nick Gorbikoff

No warranty, as the GPL says. The plugin adds a script and a stylesheet to every page, so try it on a copy of your tracker before the real one.
