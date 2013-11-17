class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  before_create :create_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :name,:midname,:surname, :password_confirmation, :remember_me

  has_many :users_roles, :dependent => :destroy
  has_many :roles, :through => :users_roles 
  has_many :posts, :dependent => :destroy
  has_many :users_votes
  has_many :votes, :through => :users_votes

  validates :email, :presence => true, :uniqueness => true
   
  def role?(role)
    return !!self.roles.find_by_name(role)
  end 
  
  private
    def create_role
      self.roles << Role.find_by_name(:user)  if ENV["RAILS_ENV"] != 'test' 
    end
end
