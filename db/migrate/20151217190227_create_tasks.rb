class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|

      t.text :russian_text
      t.text :czech_text
      t.string :type_t
      t.boolean :solved, default: false
      t.integer :variant
      t.integer :number
      t.text :answer
      t.integer :univer

      t.timestamps null: false
    end
  end
end
