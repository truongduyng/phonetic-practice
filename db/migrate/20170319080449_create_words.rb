class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :representation
      t.string :phonetic

      t.timestamps
    end
    add_index :words, :representation
    add_index :words, :phonetic
  end
end
