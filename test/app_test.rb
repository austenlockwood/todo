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

  def test_post_to_add_item_to_list_returns_a_list_name
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
