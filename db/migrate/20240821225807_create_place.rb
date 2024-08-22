class CreatePlace < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :category
      t.text :description
      t.string :phone_number
      t.string :website
      t.jsonb :hours_of_operation, default: {}
      t.decimal :rating, precision: 3, scale: 2
      t.integer :reviews_count, default: 0
      t.timestamps
    end

    add_index :places, [:latitude, :longitude]
    add_index :places, :category
  end
end
