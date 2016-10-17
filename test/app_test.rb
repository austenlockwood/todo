require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
  end

  def teardown
  end

  def app
    App
  end

  def test_has_a_root_route
    response = get "/"
    assert response.ok?
  end

  def test_add_task_to_list_returns_task_name
    list = List.create(name: "Groceries")
    response = post "/lists/#{list.name}/items"
    assert_includes response.body, list.name
  end

  # def test_get_lists_shows_all_current_user_task_lists # should show all the current task lists
  #   list = List.create(name: "Groceries")
  #   list = List.create(name: "Trip")
  #   response = get "/lists"
  #   assert_includes response.body, List.all
  # end

end

# 1 GET /lists should show all the current user tasks lists
# 2 POST /lists should create a new list for the current user
# 3 GET /lists/:name shows all incomplete items in the list with the given name
# 4 POST /lists/:name/items creates a new todo item, returning the id
# 5 PATCH /items/:id adds or updates a due date
# 6 DELETE /items/:id marks an item as complete
# 7 GET /next returns a random incomplete item
# 8 GET /search?q=... finds items containing the given string
