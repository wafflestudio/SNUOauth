class App < ActiveRecord::Base
  ##Relation
  belongs_to :user
  has_many :app_tokens, :dependent => :destroy
  has_many :app_requests, :dependent => :destroy

  ##Validation
  validates :user, :uniqueness => true
  validates :app_key, :uniqueness => true
  validates :app_secret, :uniqueness => true
  validates :redirect_uri, :format => URI::regexp(%w(http https))
end
