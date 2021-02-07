require_relative './databaseManager.rb'

class WebAppManager
  # cleans directories
  def self.clean
  end
  
  # applies template to default dir
  def self.initializeWebApp (webInfo = {})

    # si fue ingresada informacion
    unless webInfo.empty?
      # si el directorio existe
      if Dir.exist? webInfo[:dir]
        
        puts 'dir found'.green

    # si no se encuentra el directorio
      else

        puts 'dir not found'.yellow
        print "\tcreating dir... #{webInfo[:dir]}... "

        Dir.mkdir webInfo[:dir]

        puts "done\n".green

      end

      print 'creating files... '
      puts 'working'.yellow

      # documento html
      htmlf = File.open('template.html', 'r')
      htmlFile = htmlf.read
      title = '<title>'
      html = ''
      htmlFile.each_line do |line|
        if line.include? title
          line.insert(line.index(title) + title.length, webInfo[:name])
        end 
        html += line;
      end

    # creando documento HTML
    print "\tcreating html file... "
    current_file = File.open("#{webInfo[:dir]}/index.html", 'w+')
    current_file.write html
    current_file.close
    puts 'done'.green

    # creando archivos script y css con estilo por defecto
    cssFile = "*{\n\tpadding: 0;\n\tmargin: 0;\n\tbox-sizing: border-box;\n}"

    print "\tcreating script file..." 
    File.new("#{webInfo[:dir]}/script.js", 'w+')
    puts 'done'.green

    print "\tcreating css file... "
    current_file = File.new("#{webInfo[:dir]}/style.css", 'w+')
    current_file.write cssFile
    current_file.close
    puts 'done'.green

    puts "\ttemplate was sucesfully applied\n".green

    return true
    # si no se ingreso nada
    else
      puts "no web info entered".red

      return false
    end
  end

  # starts browser sync app
  def self.startLiveServer webInfo, sublime = false

    # checks if webinfo was entered
    unless webInfo.empty?
      # checks if dir exists
      if Dir.exist? webInfo[:dir]
        #starts sublime text
        if sublime
          print 'starting sublime text... '
          system "cd #{webInfo[:dir]}; subl ."
          puts 'done'.green
        end
        
        # starts web server
        print 'starting web server... '
        puts 'working'.yellow

        system "cd #{webInfo[:dir]}; browser-sync start -s --browser 'firefox' --files *"

        return true
      else
        puts 'dir doesnt exist, aborting...'.red

        return false
      end
    else
      puts 'empty webinfo'.red

      return false
    end
  end

  # looks for an already created app and opens it
  def self.openApp name

  end
end