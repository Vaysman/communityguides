class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable

  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  belongs_to :country

  attr_accessible :email, :password, :password_confirmation, :remember_me, :fullname, :shortbio, :weburl, :haslocalpw, :username

  validates :weburl, :url => {:allow_blank => true}
  validates :fullname, :length => { :maximum => 40 }
  validates :shortbio, :length => { :maximum => 500 }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
