class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :key
      t.string :label
      t.string :value

      t.timestamps
    end
  end
end
