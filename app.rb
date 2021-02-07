require_relative './appManager.rb'

# informacion del sitio
websiteInfo = Hash.new();
websiteInfo[:dir] = DEFAULT_BASE_DIR
webStatus = {}

# sublime false by default
subl = false

# cleaning before creating app
if ARGV.include? "clean"
  print "cleaning dirs...\n\t"

  # cleaning
  Database.cleanWebApps
end

# opens an already created project
if ARGV.include? "open"
  
end

unless ARGV.include? "clean" || ARGV.include? "open" || ARGV.include? "delete"

	# getting arguments
	websiteInfo[:name] = ARGV[0]
	websiteInfo[:dir] += ARGV[1]

	# initializing apps
	webStatus[:template_applied] = WebAppManager.initializeWebApp websiteInfo

	# starts server if template was applied
	if webStatus[:template_applied]
	  
	  # saving website data
	  print 'saving webapp dir... '
	  puts 'working'.yellow
	  
	  # if done
	  if Database.saveData websiteInfo
	  	puts "\twebapp saved on database\n".green
	  else
	  	puts "\twebapp database save failed\n".red
	  end

	  # starts sublime
		if ARGV.include? "subl"
			subl = true	
		end

	  # starts server
	  WebAppManager.startLiveServer websiteInfo, subl

	else
	# if not, aborts
	  puts 'could not start server, template wasnt sucesfully applied'.red
	end
end
  