# frozen_string_literal: true

# Demo data for trying the button and taking its screenshots. The people and the work are made up.
# Run by `ruby bin/demo up` through rails runner; running it twice changes nothing the second time.

Redmine::DefaultData::Loader.load("en") if Tracker.none?
Setting.default_language = "en"
Setting.notified_events = [] # no mail from the demo

admin = User.find_by_login("admin")
admin.update_columns(must_change_passwd: false)
User.current = admin

# Someone who is not a member of a project gets no add-issue right either, as on a tracker of private projects.
Role.non_member.remove_permission!(:add_issues)
Role.anonymous.remove_permission!(:add_issues)

if Project.exists?(identifier: "demo-quarry")
  puts "demo data already loaded"
  return
end

developer = Role.find_by!(name: "Developer")
viewer = Role.find_or_create_by!(name: "Viewer") do |role|
  role.permissions = [:view_issues]
  role.issues_visibility = "all"
end

make_user = lambda do |login, first, last|
  user = User.new(login: login, firstname: first, lastname: last, mail: "#{login}@example.com", language: "en")
  user.password = user.password_confirmation = "demo-password-1"
  user.save!
  user
end
dana = make_user.("dana", "Dana", "Example")
sam = make_user.("sam", "Sam", "Reader")

make_project = lambda do |name, identifier, memberships|
  project = Project.new(name: name, identifier: identifier, is_public: false, enabled_module_names: %w[issue_tracking news wiki])
  project.trackers = Tracker.all
  project.save!
  memberships.each { |user, role| Member.create!(project: project, principal: user, roles: [role]) }
  project
end

orchard = make_project.("Orchard", "demo-orchard", [[dana, developer], [sam, viewer]])
lighthouse = make_project.("Lighthouse", "demo-lighthouse", [[dana, developer], [sam, viewer]])
quarry = make_project.("Quarry", "demo-quarry", [[dana, viewer], [sam, viewer]])

[
  [orchard, "Bug", "Apples bruise in transit", "dana"],
  [orchard, "Feature", "Label the crates by variety", nil],
  [lighthouse, "Feature", "Replace the lamp timer", "dana"],
  [lighthouse, "Support", "Where is the spare key kept?", nil],
  [quarry, "Bug", "Gate sticks in cold weather", nil]
].each do |project, tracker, subject, assignee|
  Issue.create!(project: project, author: admin, tracker: Tracker.find_by!(name: tracker), subject: subject,
                status: IssueStatus.find_by!(name: "New"), priority: IssuePriority.find_by!(name: "Normal"),
                assigned_to: assignee && dana)
end
puts "demo data loaded"
