class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user,           :null => false, :default => ""
      t.belongs_to :post,           :null => false, :default => ""

      t.text :content,              :null => false, :default => ""

      t.timestamps
    end
  end
end
