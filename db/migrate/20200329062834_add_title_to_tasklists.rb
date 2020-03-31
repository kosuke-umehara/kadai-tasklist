class AddTitleToTasklists < ActiveRecord::Migration[5.2]
  def change
    add_column :tasklists, :title, :string
  end
end
