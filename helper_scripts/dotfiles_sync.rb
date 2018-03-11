require 'json'
require 'time'
require 'git'

module Git
  class Lib
    def ls_files(location=nil)
      location ||= '.'
      hsh = {}
      command_lines('ls-files', ['--stage', location]).each do |line|
        (info, file) = line.split("\t")
        (mode, sha, stage) = info.split
        file = eval(file) if file =~ /^\".*\"$/ # This takes care of quoted strings returned from git
        hsh[file] = {:path => file, :mode_index => mode, :sha_index => sha, :stage => stage}
      end
      hsh
    end
  end
end

TIME_TO_CHECK = 24 * 60 * 60 #Once per day

def file_path(path)
  home_path = ENV['HOME'] || ENV['HOME_PATH']
  File.join(home_path, path)
end

def should_sync?
  return true if ARGV[0] == '--force'
  last_sync_time_string = File.read(file_path('.dotfiles/.last_sync'))
  last_sync = Time.parse(last_sync_time_string).to_i || 0
  Time.now.to_i > last_sync + TIME_TO_CHECK
rescue StandardError => ex
  puts ex.inspect
  return true
end

def store_sync_time
  File.write(file_path('.dotfiles/.last_sync'), Time.now.to_s)
end

def check_upstream_for_updates
  git_controller.pull
end

def check_local_files_for_updates
  return unless should_sync?
  check_upstream_for_updates
  if count_not_synced > 0
    sync_upstream
  end
  git_controller.push
  store_sync_time
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
  hostname = `hostname`.strip
  uname = `uname`.strip
  git_controller.commit("Update #{Time.now.strftime('%m/%d/%Y')} #{hostname} #{uname} \n#{commit_help.join("\n")}")
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
