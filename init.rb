# Rubylode New issue button: a New issue button on every Redmine page
# Copyright (C) 2026  Nick Gorbikoff
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require "redmine"
require_relative "lib/rubylode_new_issue_button/hooks"

Redmine::Plugin.register :redmine_rubylode_new_issue_button do
  name "Rubylode New issue button"
  author "Rubylode"
  author_url "https://github.com/rubylode"
  url "https://github.com/rubylode/redmine-rubylode-new-issue-button"
  description "A New issue button in front of the search box on every page, inside a project or not, for users who may add issues"
  version "2.1.0"
  requires_redmine version_or_higher: "5.1.0"
end
