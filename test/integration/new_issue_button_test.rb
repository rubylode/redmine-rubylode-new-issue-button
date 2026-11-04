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

# frozen_string_literal: true

require File.expand_path('../../../../test/test_helper', __dir__)

class NewIssueButtonTest < Redmine::IntegrationTest
  fixtures :projects, :users, :email_addresses, :roles, :members, :member_roles, :trackers, :projects_trackers,
           :enabled_modules, :issue_statuses, :enumerations

  def test_a_member_gets_the_form_of_the_project_they_are_in
    log_user('jsmith', 'jsmith')
    get '/projects/ecookbook'

    assert_select 'script[data-href=?]', '/projects/ecookbook/issues/new'
  end

  def test_outside_a_project_the_button_opens_the_global_form
    log_user('jsmith', 'jsmith')
    get '/issues'

    assert_select 'script[data-href=?]', '/issues/new'
  end

  def test_a_signed_out_visitor_gets_no_button
    get '/projects/ecookbook'

    assert_select 'script[data-href]', false
  end

  def test_the_assets_are_in_place
    assets_directory = Redmine::Plugin.find(:redmine_rubylode_new_issue_button).assets_directory
    %w[javascripts/rubylode_new_issue_button.js stylesheets/rubylode_new_issue_button.css].each do |asset|
      assert File.exist?(File.join(assets_directory, asset)), "#{asset} is missing"
    end
  end

  test "the plugin shows its project address and author on the Plugins page" do
    plugin = Redmine::Plugin.find(:redmine_rubylode_new_issue_button)
    readme = File.read(File.expand_path("../../README.md", __dir__))
    repository_name = readme[%r{git clone https://github\.com/rubylode/([\w-]+)\.git}, 1]
    assert_equal "redmine-rubylode-new-issue-button", repository_name
    assert_equal "https://github.com/rubylode/#{repository_name}", plugin.url
    assert_equal "Rubylode", plugin.author
    assert_equal "https://github.com/rubylode", plugin.author_url
  end
  test "the plugin module is RubylodeNewIssueButton and the version is 2.0.0" do
    assert defined?(RubylodeNewIssueButton::Hooks)
    assert_equal "2.0.0", Redmine::Plugin.find(:redmine_rubylode_new_issue_button).version
  end

  test "the README has the standard headings in order, with the four install steps" do
    readme = File.read(File.expand_path("../../README.md", __dir__))
    headings = readme.scan(/^## (.+)$/).flatten
    assert_equal ["Install", "Settings", "Where it shows", "Troubleshooting", "Tests", "License"], headings
    install = readme[/^## Install$(.*?)^## /m, 1]
    assert_equal 4, install.scan(/^\d\. /).size
  end

  test "the changelog has a 2.0.0 entry" do
    changelog = File.read(File.expand_path("../../CHANGELOG.md", __dir__))
    assert_match(/^## \[2\.0\.0\] - Unreleased$/, changelog)
  end
end
