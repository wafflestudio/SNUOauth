class CreateAppTokens < ActiveRecord::Migration
  def change
    create_table :app_tokens do |t|
      t.belongs_to :app,           :null => false, :default => ""
      t.belongs_to :user,           :null => false, :default => ""

      t.string :access_token,      :null => false, :default => ""
      t.datetime :expired_at,   :null => false, :default => Time.now
      t.string :token_type,      :null => false, :default => "bearer"

      t.timestamps
    end

    add_index :app_tokens, :access_token,                :unique => true
  end
end
