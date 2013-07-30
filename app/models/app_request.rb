class AppRequest < ActiveRecord::Base
  ##Relation
  belongs_to :app

  ##Validation
  validates :app_key, :uniqueness => true
end
