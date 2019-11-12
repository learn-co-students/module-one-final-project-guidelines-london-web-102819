class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.string :symbol
    end
  end
end
