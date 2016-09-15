class AddConsoleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :console, :string
    add_column :posts, :activity, :string
    add_column :posts, :destiny_class, :string
    add_column :posts, :light_lvl, :string
    add_column :posts, :mic, :boolean
    add_column :posts, :notes, :text
  end
end
