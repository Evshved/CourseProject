class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
  :trackable, :validatable, :omniauthable
  devise :omniauthable, :omniauth_providers => [:twitter, :facebook, :vkontakte]

  has_many :instructions, dependent: :destroy

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth)
    # binding.pry
    authorization = auth_check(auth)
    if authorization.user.blank?
      user = check_existing(auth)
      if user.blank?
        user = fill_info(auth)
        if auth.provider == "twitter"
         user.save(:validate => false)
        else
         user.save
        end
      end
    end
    user
  end

  def self.auth_check(auth)
    Authorization.where(provider: auth.provider,
                        uid: auth.uid.to_s,
                        token: auth.credentials.token,
                        secret: auth.credentials.secret).first_or_initialize
  end

  def self.check_existing(auth)
    User.find_by_uid_and_provider(auth.uid.to_s, auth.provider)
  end

  def self.fill_info(auth)
    user          = User.new
    user.password = Devise.friendly_token[0, 10]
    user.name     = auth.info.name
    user.provider = auth.provider
    user.uid      = auth.uid
    user.email    = auth.provider + auth.uid + "@gmail.com"
    user
  end
end
