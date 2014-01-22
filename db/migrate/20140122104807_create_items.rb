class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, limit: 50, null: false
      t.text :description
      t.string :vendor, limit: 50
      t.decimal :starting_price, precision: 9, scale: 2, null: false

      t.references :category, null: false

      t.timestamps
    end
  end
end
