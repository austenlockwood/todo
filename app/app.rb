require "./config/dependencies"
require "better_errors"

class App < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/assets'
  use Rack::MethodOverride #makes puts and patch stuff work

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  get "/" do
    erb :"homepage.html"
  end

  get "/lists" do # displays and list of all lists displays
    @lists = List.all
    erb :"listspage.html" # passing a symbol (like the ":" here) tells Sinatra to look in views for that file.
  end

  ##
  # displays and user gets a list of all of the items in the specific list
  get "/lists/:name" do #show this particular list
    @list = List.find_by(name: params["name"])
    @items = Item.where(list_id: @list.id)
    erb :"view_list.html"
  end

  post "/items" do
    @item = Item.create(params["item"])
    list = List.find(@item.list_id)
    redirect to("/lists/#{list.name}") # redirect to the list name that matches our item's list id for the item
  end

  # Add a list
  post "/lists" do  # user names a new list and it is created, then redirects to listspage.
    List.create(params["list"])
    redirect to('/lists')
  end

  # Add an item to a given list
  post "/lists/:name/items" do #view_list.html
    @item = Item.create(params["item"])
    @list = List.find(@item.list_id)
    redirect to("/lists/#{@list.name}") # redirect to the list name that matches our item's list id for the item

    # @list = List.find_by(name: params["name"])
    #
    # erb :"view_list.html"
  end

  delete "/items/:id" do
    @list = List.find(@item.list_id)
    @item = Item.destroy(params["item"])
    redirect to("/lists/#{@list.name}")
  end

  run! if app_file == $PROGRAM_NAME
end



# 5 PATCH /items/:id adds or updates a due date
# 6 DELETE /items/:id marks an item as complete
# 7 GET /next returns a random incomplete item
# 8 GET /search?q=... finds items containing the given string

# 1 GET /lists should show all the current user tasks lists [DONE]
# 2 POST /lists should create a new list for the current user [DONE]
# 3 GET /lists/:name shows all incomplete items in the list with the given name [DONE]
# 4 POST /lists/:name/items creates a new todo item, returning the id [DONE]
