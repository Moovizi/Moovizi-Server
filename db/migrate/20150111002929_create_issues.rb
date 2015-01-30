class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :status
      t.float :latitude
      t.float :longitude
      t.string :description
      t.string :photo

      t.timestamps null: false
    end
  end
end
