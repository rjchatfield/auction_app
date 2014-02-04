class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :items, :avatar_file_name,     :string
    add_column :items, :avatar_content_type,  :string
    add_column :items, :avatar_file_size,     :integer
    add_column :items, :avatar_updated_at,    :datetime
  end
end
