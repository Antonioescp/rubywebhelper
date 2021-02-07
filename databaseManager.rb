require './envVars.rb'

class Database

	# opens database
	def self.open
	  # opens json file and parse it
	  f = File.open("dirs.json", 'r')
	  database = JSON.parse(f.read)
	  f.close

	  return database
	end

	# looks for app in the database
	def self.search name
	  # downcases the name
	  name.downcase!

	  # opens database first
	  db = self.open

	  # looks for app using name
	  db["webApps"].each do | k, v |
	  	
	  end
	end

	# saves current website info
	def self.saveData webInfo = {}
		dirs = {}
		# is info empty
		unless webInfo.empty?
			# if not empty checks file existence
			print "\topening dirs file... "
			if File.exist? 'dirs.json'
			  puts 'found'.green

			  print "\tsaving... "

			  f = File.open('dirs.json', 'r')
			  content = f.read
			  f.close
			  dirs = JSON.parse content
			  dirs["webApps"].push webInfo
			  f = File.open('dirs.json', 'w+')
			  f.write JSON.generate(dirs)
			  f.close

			  puts 'done'.green

			  return true
			# if files doesnt exist then
			else
			  puts "not found".yellow
			  print "\tcreating dir file... "
			  dirs[:webApps] = [webInfo]
			  f = File.open('dirs.json', 'w+')
			  f.write(JSON.generate(dirs))
			  f.close

			  puts "done\n".green

			  return true
			end
		else
		  puts "\tcant save empty app".red
		  return false
		end
	end

	# reads website info and deletes all de apps
	def self.cleanWebApps
	  # if file exist
	  if File.exist? 'dirs.json'
	  	print 'opening file... '
	  	f = File.open('dirs.json', 'r')
	  	content = f.read
	  	f.close
	  	dirs = JSON.parse content
	  	puts 'done'.green

	  	print 'cleaning dirs... '

	  	dirs["webApps"].each do |webApp|
	  	  print "\tdeleting #{webApp["name"]}... "
	  	  if Dir.exist? webApp["dir"]
	  	  	FileUtils.rm_r webApp["dir"]
	  	  	puts 'done'.green
	  	  else
	  	  	puts 'not found/already deleted'.yellow
	  	  end
	  	end

	  	File.delete('dirs.json');

	  	puts 'dirs were cleaned'.green
	  # if file is not found
	  else
	  	puts 'there is no app to delete'.green
	  end
	end
end