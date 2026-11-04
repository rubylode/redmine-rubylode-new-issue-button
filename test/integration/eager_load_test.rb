# frozen_string_literal: true

require File.expand_path('../../../../test/test_helper', __dir__)

# Production loads every file under the plugin's autoload paths at boot. The test environment does not, so a file whose
# path and constant disagree passes every other test and then stops Redmine from starting.
class EagerLoadTest < ActiveSupport::TestCase
  test 'every file in the plugin code paths defines the constant its path names' do
    Zeitwerk::Loader.eager_load_all
  end

  test 'no lib folder is named after the old module' do
    refute Dir.exist?(File.expand_path('../../lib/redmine_rubylode_new_issue_button', __dir__))
  end
end
