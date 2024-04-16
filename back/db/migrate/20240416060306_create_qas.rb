class CreateQas < ActiveRecord::Migration[7.1]
  def change
    create_table :qas do |t|
      t.string :prompt
      t.string :answer

      t.timestamps
    end
  end
end
