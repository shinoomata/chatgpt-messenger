class AddUserNameAndStyleToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :user_name, :string
    add_column :messages, :style, :string
  end
end
