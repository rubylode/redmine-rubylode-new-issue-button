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
end
