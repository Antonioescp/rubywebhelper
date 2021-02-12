require_relative "Database.rb"

# main class for app management
class App

  # deletes every app created until now
  def self.deleteAll
    # list all apps before deleting
    puts 'This apps will be deleted'
    Database.list
    db = Database.read

    # deletes every directory
    db["webApps"].length.times do | num |
      Database.deleteApp 0
    end


  end

  # deletes an existing app
  def self.delete foldername

    print 'app '

    # checks app existence
    if webApp = Database.search(foldername, true)

      puts 'exists'.green
      print "deleting app.."

      puts 'done'.green if Database.deleteApp webApp

    else
      puts 'doesnt exist'.yellow
    end

  end

  # creates new webapp
  def self.create title, foldername, type = "default"

  	# HTML file treatment
  	htmlContent = Database.readFile HTML_FILE_DIR

  	# inserting title to document
  	htmlContent = Database.insertHTMLTitle htmlContent, title 
  	webApp = Database.buildAppHash title, foldername

  	# saving to database
  	if Database.save webApp
      puts "Aplicacion guardada".green

      puts "Crando aplicacion..."

      # looks for apps dir
      if Dir.exist? PROJECTS_DIR

        print "creando archivos..."

        # creates directory
        FileUtils.mkdir webApp["dir"]

        # creates html file
        Database.writeFile webApp["dir"] + '/index.html', htmlContent

        # creates css file
        Database.copyFile 'templates/style.css', webApp["dir"] + '/style.css'

        # creates script file
        Database.copyFile 'templates/script.js', webApp["dir"] + '/script.js'

        puts 'done'.green

      else

        puts 'directorio de aplicacion no existe'.yellow

      end
    else
      puts "Aplicacion ya existe".yellow
    end
  end

end