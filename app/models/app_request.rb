class AppRequest < ActiveRecord::Base
  ##Relation
  belongs_to :app
  belongs_to :app_token

  ##Validation
  validates :app, :presence => true
  validates :app_token, :presence => true
end
