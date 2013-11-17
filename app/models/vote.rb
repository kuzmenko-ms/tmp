class Vote < ActiveRecord::Base
  belongs_to :post
  has_many :users_votes
  has_many :users, :through => :users_votes
end
