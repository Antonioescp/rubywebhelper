require_relative "Database.rb"

# main class for app management
class App

  # deletes an existing app
  def self.delete foldername

    print 'app '

    # checks app existence
    if Database.search foldername, true

      puts 'exists'.green
      puts "sure you want to delete #{foldername}?(y/n)"
      response = gets.chomp

      if response == 'y'
        print "deleting app.."

        # code for deleting an app goes here

        puts 'done'.green
      else
        puts "app will not be deleted".yellow
      end

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