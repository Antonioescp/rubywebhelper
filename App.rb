require_relative "Database.rb"

# main class for app management
class App

  # dirs and files
  HTML_FILE_DIR = 'templates/template.html'
  CSS_FILE_DIR = 'templates/style.css'
  SCRIPT_FILE_DIR = 'templates/script.js'
  	# dir were projects will be saved
  PROJECTS_DIR = 'C:\Users\Anahi Ponce\Documents\Toni\Proyectos/'
  
  # creates new webapp
  def self.create title, foldername, type = "default"

  	# HTML file treatment
  	htmlfile = File.open HTML_FILE_DIR, "r"
  	htmlcontent = htmlfile.read
  	htmlfile.close

  	# inserting title to document
  	htmlcontent.insert(htmlcontent.index("<title>") + "<title>".length, title)
  	webApp = {"name" => "#{title}", "dir" => PROJECTS_DIR + foldername.downcase}

  	# saving to database
  	if Database.save webApp
      puts "Aplicacion guardada"
    else
      puts "Aplicacion ya existe"
    end
  	
  end

end