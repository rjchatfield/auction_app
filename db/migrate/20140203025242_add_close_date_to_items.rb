class AddCloseDateToItems < ActiveRecord::Migration
  def change
    add_column :items, :close_date, :datetime
  end
end
