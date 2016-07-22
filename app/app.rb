require "./config/dependencies"

class App < Sinatra::Base
  # YOU NEED DIS
  set :public_folder, File.dirname(__FILE__) + '/assets'
  # AND DIS
  use Rack::MethodOverride

  get "/" do
    @lists = List.all
    erb :"homepage.html"
  end

  post "/lists" do
    List.create(params["list"])
    redirect to('/')
  end

  post "/lists/:name/items" do
    @list = List.find_by name: params["name"]
    @items = Item.where(list_id: @list.id)
    erb :"add_item.html"
  end

  run! if app_file == $PROGRAM_NAME
end
