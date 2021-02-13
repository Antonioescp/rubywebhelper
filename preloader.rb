require 'console-colors'
require 'json'
require 'fileutils'

# browserSync
require_relative 'Server.rb'

# sublime text
require_relative 'Sublime.rb'

  # dirs and files
  HTML_FILE_DIR = 'templates/template.html'.freeze
  CSS_FILE_DIR = 'templates/style.css'.freeze
  SCRIPT_FILE_DIR = 'templates/script.js'.freeze
  	# dir were projects will be saved
  PROJECTS_DIR = 'C:\Users\Anahi Ponce\Documents\Toni\Proyectos/'.freeze

  # Database info
  DATABASE_NAME = 'dirs.json'.freeze