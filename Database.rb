require_relative 'preloader.rb'

# manages a database in JSON format
class Database

  # reads database content
  def self.read
 
  	# reads file and parses it to ruby structure
  	db = self.open
  	content = db.read
  	db.close
  	return JSON.parse(content)
 
  end

  # saves data to database
  def self.save webInfo = {}

    # creates file if it doesn't exist
    self.read unless self.exist?

    # checks if app already exist in db
    unless self.search(webInfo["dir"])

      # reads database
      db = self.read

      # inserts new data
      db["webApps"].push webInfo

      # saves to database
      self.write db

      return true

    else

      return false
      
    end

  end
  
  # opens database and looks for an item
  def self.search appDir, byFolderName = false

  	appDir = PROJECTS_DIR + "#{appDir}" if byFolderName == true

    # found status flag
    found = false

    # look for the app by name
    self.read()["webApps"].each do | webApp |
      found = true if webApp["dir"] == appDir
  	end

    return found
  end

  # opens database and shows web apps as list
  def self.list

    # read database
    db = self.read

    # prints every webapp data if empty just prints empty
    unless db["webApps"].empty?

      db["webApps"].each do | webApp |
        puts "Appname: #{webApp["name"]} Folder: #{webApp["dir"]}"
      end

    else

      puts 'empty'

    end

  end

  ###
  # Documents treatment
  ###

  # reads a file and returns its content
  def self.readFile dir
  	return File.open(dir, 'r').read
  end

  # copies a file to a directory
  def self.copyFile source, destiny
  	self.writeFile destiny, self.readFile(source)
  end

  # writes to file
  def self.writeFile target, content
  	f = File.open target, 'w'
  	f.write content
  	f.close
  end

  # HTML modifications
  def self.insertHTMLTitle doc, title
  	doc.insert(doc.index("<title>") + "<title>".length, title)

  	return doc
  end

  # creates ruby webapp structure
  def self.buildAppHash title, foldername
  	return {"name" => title, "dir" => PROJECTS_DIR + foldername}
  end

  ###
  # End of Document treatment
  ###

  private

    # verifies file existence
    def self.exist?
      File.exist? DATABASE_NAME
    end

    # opens database with read-only permission as default
    def self.open permission = 'r'

      # checks file existance
      if self.exist?

        # opens file
        db = File.open DATABASE_NAME, permission

      else

        # creates file
        db = File.open DATABASE_NAME, 'w+'
        self.write

      end

      # returns database
      return db
    end

    # writes ruby structure to JSON
    def self.write structure = {webApps: []}
   
      # opens file in writing mode and saves new data
      db = self.open 'w'
      db.write JSON.generate(structure)
      db.close
   
    end
end