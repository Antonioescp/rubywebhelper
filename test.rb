require_relative 'Database.rb'

webInfo = {name: "test", dir: 'newdir'}

Database.save webInfo

pp Database.read