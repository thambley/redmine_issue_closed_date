require 'redmine'
require 'dispatcher'
require 'query_patch_closed_date'
require 'close_issue_patch'


Redmine::Plugin.register :redmine_issue_closed_date do
  name 'Redmine Issue Closed Date plugin'
  author 'Todd Hambley'
  description 'A plugin that saves the date when the issue is closed'
  version '0.0.1'
end

Dispatcher.to_prepare :redmine_issue_closed_date do
	require_dependency 'query'
	
	unless Query.included_modules.include? IssueClosedDatePlugin::IssueQueryPatch
		Query.send( :include, IssueClosedDatePlugin::IssueQueryPatch)
	end
end