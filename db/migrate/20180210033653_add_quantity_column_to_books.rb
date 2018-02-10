class AddQuantityColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :quantity, :integer
  end
end
