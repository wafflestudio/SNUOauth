class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.belongs_to :user,           :null => false, :default => ""

      t.string :name,              :null => false, :default => ""
      t.string :publisher,              :null => false, :default => ""
      t.text :description,              :null => false, :default => ""
      t.string :website,              :null => false, :default => ""

      t.string :app_key,           :null => false, :default => ""
      t.string :app_secret,        :null => false, :default => ""

      t.string :redirect_uri,      :null => false, :default => ""

      t.timestamps
    end

    add_index :apps, :app_key,                :unique => true
    add_index :apps, :app_secret,             :unique => true
  end
end
