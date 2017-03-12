Devise.setup do |config|
  config.omniauth :twitter, Rails.application.secrets.twitter_consumer_key, Rails.application.secrets.twitter_consumer_secret
  config.omniauth :facebook, Rails.application.secrets.facebook_consumer_key, Rails.application.secrets.facebook_consumer_secret
  config.omniauth :vkontakte, Rails.application.secrets.vk_consumer_key, Rails.application.secrets.vk_consumer_secret
  config.secret_key = '78055cb8ed847d3368b9edaf7cdfcd3133b3399fa8844eb727472101bf57b26592a8a4ce10e8efd359f7ce7e7ee05927d6dabcc22783f7bf0b5cc140f8ee66a4'
  require 'devise/orm/active_record'
end
