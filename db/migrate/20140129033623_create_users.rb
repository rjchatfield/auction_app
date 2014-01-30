class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name,       null: false, limit: 50
      t.string :last_name,        null: false, limit: 50
      t.string :email,            null: false
      t.string :password_digest,  null: false
      t.boolean :admin

      t.timestamps
    end
  end
end
