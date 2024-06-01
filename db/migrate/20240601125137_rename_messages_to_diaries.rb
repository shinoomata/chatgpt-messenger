class RenameMessagesToDiaries < ActiveRecord::Migration[7.0]
  def change
    rename_table :messages, :diaries
  end
end
