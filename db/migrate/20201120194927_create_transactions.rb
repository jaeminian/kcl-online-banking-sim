class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :receiver
      t.float :amount
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
