class CreateAppRequests < ActiveRecord::Migration
  def change
    create_table :app_requests do |t|
      t.belongs_to :app,        :null => false, :default => ""
      t.belongs_to :app_token,        :null => false, :default => ""

      t.string :type,          :null => false, :default => ""
      t.integer :status,        :null => false, :default => 0
      t.string :message,       :null => false, :default => ""

      t.timestamps
    end
  end
end
