class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.references :country, index: true
      t.timestamps
      t.string :latitude
      t.string :longitude
    end
  end
end
