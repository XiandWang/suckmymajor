class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name, unique: true

      t.timestamps null: false
    end
  end
end
