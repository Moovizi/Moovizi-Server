class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :code
      t.boolean :accessible

      t.timestamps null: false
    end
  end
end
