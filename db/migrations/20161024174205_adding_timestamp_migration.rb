class AddingTimestampMigration < ActiveRecord::Migration
  def change
    add_column :items, :timestamps
  end
end
