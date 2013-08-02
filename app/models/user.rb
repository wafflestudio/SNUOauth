class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  ##Relation
  has_many :apps, :dependent => :destroy
  has_many :app_tokens, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  ##Method
  def self.find_for_mysnu_oauth(email, token)
    provider = "mysnu"
    user = User.where(:provider => provider, :uid => email).first
    unless user
      user = User.create(provider: provider,
                         uid:email,
                         token:token,
                         email:email,
                         password:Devise.friendly_token[0,40]
                        )
    else
      user.update_attributes({token: token})
    end
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider:auth.provider,
                         uid:auth.uid,
                         token:auth.credentials.token,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,40]
                        )
    else
      user.update_attributes({token: auth.credentials.token})
    end
    user
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider:auth.provider,
                         uid:auth.uid,
                         token:auth.credentials.token,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,40]
                        )
    else
      user.update_attributes({token: auth.credentials.token})
    end
    user
  end
end
