class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users ,:mobile_phone , :integer
  	add_column :users ,:gender , :string
  	add_column :users ,:birth_date , :string
  end
end
