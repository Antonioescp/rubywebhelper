require_relative 'AppManager.rb'

if (ARGV.length == 3) && (ARGV.include? 'create')
  App.create ARGV[1], ARGV[2]
end

if (ARGV.include? 'delete') && (ARGV.length == 2)
  App.delete ARGV[1]
end

if (ARGV.include? 'clean') && (ARGV.length == 1)
  App.deleteAll
end

if (ARGV.include? 'list') && (ARGV.length == 1)
  Database.list
end

if (ARGV.include? 'open') && (ARGV.length == 2) && (!ARGV.include? 'delete')
  App.open ARGV[1]
end

if (ARGV.include?('help') || ARGV.include?('?')) && (ARGV.length == 1)
  puts 'This are the commands available'
  puts 'create'
  puts 'delete'
  puts 'clean'
  puts 'list'
  puts 'open'
end 