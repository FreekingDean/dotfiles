require 'git'
require 'awesome_print'

def check_upstream_for_updates
end

def check_local_files_for_updates
  git_controller.remote("origin")
  git_controller.remote("origin").fetch
  git_controller.remote("origin")
  if count_not_synced > 0
    sync_upstream
  end
end

def git_controller
 #, :log => Logger.new(STDOUT))
 @git ||= Git.open('~/.dotfiles')
end

def sync_upstream
  git_controller.add
  commit_help = []
  commit_help << untracked.map {|f| "New File: #{f.path}"}
  commit_help << updated.map {|f| "Updated: #{f.path}"}
  git_controller.commit("Updated dotfiles\n#{commit_help.join("\n")}")
end

def count_not_synced
  untracked.count + updated.count
end

def untracked
  current_status.select(&:untracked)
end

def updated
  current_status.reject { |f| f.type.nil? }
end

def current_status
  @current_status ||= git_controller.status
end

check_local_files_for_updates
