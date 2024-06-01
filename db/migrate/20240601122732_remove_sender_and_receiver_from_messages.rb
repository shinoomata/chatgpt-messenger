class RemoveSenderAndReceiverFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :sender, :string
    remove_column :messages, :receiver, :string
  end
end
