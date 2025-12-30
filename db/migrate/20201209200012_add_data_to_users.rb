class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :securelogin, :string, default: 0, null: true)
  end
end
