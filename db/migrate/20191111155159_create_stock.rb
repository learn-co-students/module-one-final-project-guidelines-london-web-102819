class CreateStock < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :price
      t.string :company_name 
    end
  end
end
