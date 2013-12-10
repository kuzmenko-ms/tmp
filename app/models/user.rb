class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  before_create :create_role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :name,:midname,:surname, :password_confirmation, :remember_me
       attr_accessible :avatar,:nickname, :provider, :url, :username
    has_attached_file :avatar,:styles => { :small => '28x28#', :medium => '60x60#' , :big => '100x100#'}
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

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => access_token.extra.raw_info.domain+'@vk.com', :password => Devise.friendly_token[0,20]) 
    end
  end
  
end
