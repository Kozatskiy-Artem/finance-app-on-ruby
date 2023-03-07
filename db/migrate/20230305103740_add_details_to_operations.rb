class AddDetailsToOperations < ActiveRecord::Migration[7.0]
  def change
    change_column :operations, :odate, :date
  end
end
