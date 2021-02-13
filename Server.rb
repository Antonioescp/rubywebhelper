class Server
  # stars browser-sync server
  def self.start dir
  	system("cd #{dir} && browser-sync start -s --files *")
  end
end