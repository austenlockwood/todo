require "./config/dependencies"

class App < Sinatra::Base
  # YOU NEED DIS
  set :public_folder, File.dirname(__FILE__) + '/assets'
  # AND DIS
  use Rack::MethodOverride

  get "/" do
    erb :"homepage.html"
  end

  run! if app_file == $PROGRAM_NAME
end
