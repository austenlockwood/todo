class List < ActiveRecord::Base
  has_many :items

  def add_item!
    Item.create(list_id: id, task: task, date_created: Date.now, due_date: due_date, completed: completed)
  end
end
