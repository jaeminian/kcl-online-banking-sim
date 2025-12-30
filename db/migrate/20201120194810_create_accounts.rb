class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :accnumber
      t.string :sortcode
      t.string :accname
      t.integer :curr_id

      t.timestamps
    end
  end
end
