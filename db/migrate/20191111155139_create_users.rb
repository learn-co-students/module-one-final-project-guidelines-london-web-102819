class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :account_balance, :precision => 10, :scale => 2, :null => false, :default => 0.0
      t.string :email
      t.string :password
      t.string :security_answer
    end
  end
end
