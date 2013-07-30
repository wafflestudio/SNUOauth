class Post < ActiveRecord::Base
  ## Relation
  belongs_to :user
  has_many :comments, :dependent => :destroy

  ## Validation
  validates :user, :presence => true
end
