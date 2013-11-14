class Post < ActiveRecord::Base
  
  after_create :create_vote

  belongs_to :user
  has_one :vote, :dependent => :destroy
  validates :title, :content, :presence => true
  

  protected
    def create_vote
      self.vote = Vote.create(:score => 0)
    end
end
