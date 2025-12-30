class CreateConsoles < ActiveRecord::Migration[6.0]
  def change
    create_table :consoles do |t|
      t.string :footer_b
      t.string :footer_t
      t.string :header_b
      t.string :header_t
      t.string :corona_b
      t.string :corona_t
      t.string :banner_b
      t.string :banner_t

      t.timestamps
    end
  end
end
