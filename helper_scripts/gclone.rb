repo = ARGV.split("/")

def print_usage
  "gclone repo_name\ngclone user/repo_name"
end

if repo.count == 0 || repo.count > 2
  print_usage
if repo.count == 1
  cmd = "git clone git@github.com:FreekingDean/#{ARGV[0]}.git"
else

end
