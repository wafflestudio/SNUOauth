class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user,           :null => false, :default => ""

      t.string :title,              :null => false, :default => ""
      t.text :content,              :null => false, :default => ""

      t.timestamps
    end
  end
end
