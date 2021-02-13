# a class for sublime text control
class Sublime
  # starts sublime in given directory
  def self.start dir
  	system("cd #{dir} && subl .")
  end
end