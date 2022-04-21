class CreateDistances < ActiveRecord::Migration[6.1]
  def change
    create_table :distances do |t|
      t.string :source_location, null: false
      t.string :destination_location, null: false
      t.json :distance_range, default: {km: nil, miles: nil}, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
