require "./config/dependencies"
require "better_errors"

class App < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/assets'
  use Rack::MethodOverride #makes puts and patch stuff work.  This is why you need _method

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

  # displays and user gets a list of all of the items in the specific list
  get "/lists/:name" do # show this particular list
    list_name = params["name"] # storing string, like "Shopping" from Sinatra
    @list = List.find_by(name: list_name) # ActiveRecord code
    @items = Item.where(list_id: @list.id)
    erb :"view_list.html"
  end

  # post "/items" do
  #   @item = Item.create(params["item"]["due_date"])
  #   list = List.find(@item.list_id)
  # # redirect to the list name that matches our item's list id for the item
  #   redirect to("/lists/#{list.name}")
  # end

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

    # erb :"view_list.html"
  end

  patch "/items/:id" do
    @item = Item.find(params["id"])
    @list = List.find(@item.list_id)
    @item.due_date = params["due_date"]
    @item.save
    redirect to("/lists/#{@list.name}")
  end

  delete "/items/:id" do
    @item = Item.find(params["id"])
    @list = List.find(@item.list_id)
    @item.destroy
    redirect to("/lists/#{@list.name}")
  end

  run! if app_file == $PROGRAM_NAME
end

# Note: for more accurate diagnostics, use binding.pry, not the f test.  binding.pry shows you what all the params actually are for the object, whereas the f test just shows what was packaged in the form stage.  It's a BetterErrors quirk.

# 5 PATCH /items/:id adds or updates a due date
# 7 GET /next returns a random incomplete item
# 8 GET /search?q=... finds items containing the given string

# 1 GET /lists should show all the current user tasks lists [DONE]
# 2 POST /lists should create a new list for the current user [DONE]
# 3 GET /lists/:name shows all incomplete items in the list with the given name [DONE]
# 4 POST /lists/:name/items creates a new todo item, returning the id [DONE]
# 6 DELETE /items/:id marks an item as complete
