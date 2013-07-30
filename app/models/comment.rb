class Comment < ActiveRecord::Base
  ## Relation
  belongs_to :user
  belongs_to :post

  ## Validation
  validates :user, :presence => true
  validates :post, :presence => true
end
