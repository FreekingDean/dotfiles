def print_usage
  "gclone repo_name\ngclone user/repo_name"
end

if ARGV.count != 1
  print_usage
  exit 1
end

if ARGV[0].include?("/")
  cmd = "git clone https://github.com/#{ARGV[0]}.git"
else
  cmd = "git clone git@github.com:FreekingDean/#{ARGV[0]}.git"
end

system(cmd)
exit($?.exitstatus)
