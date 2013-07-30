class CreateAppRequests < ActiveRecord::Migration
  def change
    create_table :app_requests do |t|
      t.belongs_to :app,        :null => false, :default => ""

      t.string :permission,        :null => false, :default => ""
      t.string :oauth_token,       :null => false, :default => ""
      t.string :access_token,      :null => false, :default => ""

      t.string :type,          :null => false, :default => ""
      t.string :status,        :null => false, :default => ""
      t.string :message,       :null => false, :default => ""

      t.timestamps
    end
  end
end
