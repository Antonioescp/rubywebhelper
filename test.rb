require_relative 'App.rb'

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