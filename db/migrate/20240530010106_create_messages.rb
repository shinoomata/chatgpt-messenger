class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :sender
      t.string :receiver
      t.text :content
      t.text :indirect_message

      t.timestamps
    end
  end
end
