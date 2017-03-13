class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :set_locale


  private

  def dont_allow_user_self_registration
    if ['devise/registrations','devise_invitable/registrations'].include?(params[:controller]) && ['new','create'].include?(params[:action])
      redirect_to root_path
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def extract_locale
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
