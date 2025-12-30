class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :bigname
      t.string :shortname

      t.timestamps
    end
  end
end
