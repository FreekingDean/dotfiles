def print_usage
  program_name = File.basename($0, File.extname($0))
  puts <<-ENDMSG
#{program_name} <options> <token>
  options:
    --dry-run (Prints the files in their updated state instead of writing them)
  usage:
    #{program_name} --dry-run abcdefg
ENDMSG
end

dry_run = ARGV[0] == '--dry-run'
ARGV.shift if dry_run
token = ARGV.shift

if token.nil?
  print_usage
  exit(1)
end

if token.start_with?('--')
  puts "unknown option #{token}"
  print_usage
  exit(1)
end

if ARGV.count > 0
  puts "unkown arguments #{ARGV}"
  print_usage
  exit(1)
end



if !dry_run
  print "update gemfury token to '#{token}' (y/n)? "
  if STDIN.gets.chomp != 'y'
    exit(0)
  end
end

bundle_config = ""
bundle_config_path = "#{ENV['HOME']}/.bundle/config"
File.open(bundle_config_path).each do |line|
  if line.include?('GEM__FURY__IO')
    first_half = line.split(': ')[0]
    bundle_config << "#{first_half}: #{token}\n"
  else
    bundle_config << line
  end
end

if dry_run
  puts "\n#{bundle_config_path}\n"
  puts bundle_config
else
  File.write(bundle_config_path, bundle_config)
end

gemrc = ""
gemrc_path = "#{ENV['HOME']}/.gemrc"
File.open(gemrc_path).each do |line|
  if line.include?('gem.fury.io')
    last_half= line.split('@')[1]
    gemrc << "- https://#{token}@#{last_half}"
  else
    gemrc << line
  end
end

if dry_run
  puts "\n#{gemrc_path}\n"
  puts gemrc
else
  File.write(gemrc_path, gemrc)
end
