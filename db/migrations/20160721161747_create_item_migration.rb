class CreateItemMigration < ActiveRecord::Migration
  def change
    create_table(:items) do |t|
      t.integer :list_id
      t.string :task
      t.date :date_created
      t.date :due_date
      t.boolean :completed
    end
  end
end
