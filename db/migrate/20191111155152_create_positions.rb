class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.integer :portfolio_id
      t.integer :stock_id 
    end
  end
end
