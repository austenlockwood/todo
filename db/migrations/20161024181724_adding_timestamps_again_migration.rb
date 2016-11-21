class AddingTimestampsAgainMigration < ActiveRecord::Migration
  def change
    add_timestamps :items
  end
end
