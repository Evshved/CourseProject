class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :authenticate_user!, raise: false
  def all
    p env["omniauth.auth"]
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :twitter, :all
  alias_method :vkontakte, :all
end
