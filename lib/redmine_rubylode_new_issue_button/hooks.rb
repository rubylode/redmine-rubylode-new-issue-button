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

module RubylodeNewIssueButton
  # Redmine only offers a "New issue" link inside a project (the "+" menu). This puts one on every page for a user
  # who may add issues. The server decides whether to show it and where it goes (the project's form inside a
  # project, the global form elsewhere) and hands that to the script, so the label is translated and the button
  # never appears for someone who could not use it.
  class Hooks < Redmine::Hook::ViewListener
    PLUGIN = 'redmine_rubylode_new_issue_button'

    def view_layouts_base_html_head(_context)
      stylesheet_link_tag('rubylode_new_issue_button', plugin: PLUGIN)
    end

    # The script sits at the end of the body, so it runs as soon as the header above it exists.
    def view_layouts_base_body_bottom(context)
      path = new_issue_path(context[:hook_caller], context[:project])
      return if path.nil?

      javascript_include_tag('rubylode_new_issue_button', plugin: PLUGIN, data: { href: path, label: ::I18n.t(:label_issue_new) })
    end

    private

    def new_issue_path(view, project)
      user = User.current
      return unless user.logged?

      if project&.persisted? && user.allowed_to?(:add_issues, project)
        view.new_project_issue_path(project)
      elsif user.allowed_to?(:add_issues, nil, global: true)
        view.new_issue_path
      end
    end
  end
end
