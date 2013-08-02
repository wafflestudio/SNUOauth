class AppRequest < ActiveRecord::Base
  ##Constant
  SUCCESS=0
  HTTP_ERROR=1

  ##Relation
  belongs_to :app
  belongs_to :app_token

  ##Validation
  validates :app, :presence => true
  validates :app_token, :presence => true
end
