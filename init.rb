require 'redmine'
# Including dispatcher.rb in case of Rails 2.x
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

require_dependency 'query_patch_closed_date'
require_dependency 'close_issue_patch'

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'query'
	
    unless Query.included_modules.include? IssueClosedDatePlugin::IssueQueryPatch
      Query.send( :include, IssueClosedDatePlugin::IssueQueryPatch)
    end
  end
else
  Dispatcher.to_prepare :redmine_issue_closed_date do
    require_dependency 'query'
	
    unless Query.included_modules.include? IssueClosedDatePlugin::IssueQueryPatch
      Query.send( :include, IssueClosedDatePlugin::IssueQueryPatch)
    end
  end
end

Redmine::Plugin.register :redmine_issue_closed_date do
  name 'Redmine Issue Closed Date plugin'
  author 'Todd Hambley'
  description 'A plugin that saves the date when the issue is closed'
  version '0.0.2'
end