
require_relative 'preloader.rb'

# manages a database in JSON format
class Database

  DATABASE_NAME = 'dirs.json'

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

    # reads database
    db = self.read

    # inserts new data
    db["webApps"].push webInfo

    # saves to database
    self.write db

  end
  
  # opens database and looks for an item
  def self.search name

    # found status flag
    found = nil

    # look for the app by name
    self.read()["webApps"].each do | webApp |
      found = true if webApp["name"] == name
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