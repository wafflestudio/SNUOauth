class AppToken < ActiveRecord::Base
  ##Relation
  belongs_to :user
  belongs_to :app
  has_many :app_requests, :dependent => :destroy

  ##Validation
  validates :user, :presence => true
  validates :app, :presence => true
end
