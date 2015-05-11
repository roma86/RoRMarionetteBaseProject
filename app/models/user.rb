class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter, :vkontakte, :facebook]

  has_many :authentications

  def self.from_omniauth(auth_hash)
    user = User.where(:provider => auth_hash['provider'], :uid => auth_hash['uid']).first
    unless user
      user = User.new
      user.password = Devise.friendly_token[0,20]
      user.name     = auth_hash['name']
      user.image    = auth_hash['image']
      user.provider = auth_hash['provider']
      user.uid      = auth_hash['uid']
      user.email    = auth_hash['email']
    end
    user.save unless user.email.blank?
    user
  end

  def self.build_omniauth_auth_cookie_hash(data)
    {
        'provider' => data.provider,
        'uid' => data.uid.to_i,
        'access_token' => data.credentials.token,
        'access_secret' => data.credentials.secret,
        'first_name' => data.screen_name,
        'email' => data.info.email,
        'image' => data.info.image
    }
  end
end