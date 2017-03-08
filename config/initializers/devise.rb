Devise.setup do |config|
  config.omniauth :twitter, Rails.application.secrets.twitter_consumer_key, Rails.application.secrets.twitter_consumer_secret
  config.omniauth :facebook, Rails.application.secrets.facebook_consumer_key, Rails.application.secrets.facebook_consumer_secret
  config.omniauth :vkontakte, Rails.application.secrets.vk_consumer_key, Rails.application.secrets.vk_consumer_secret
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
end
