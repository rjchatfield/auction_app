class AddCategoryDescription < ActiveRecord::Migration
  def up
    add_column :categories, :description, :string, { limit: 140 }
    change_column :categories, :name, :string, { limit: 50 }
  end

  def down
    remove_column :categories, :description
    change_column :categories, :name, :string
  end
end
