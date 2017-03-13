source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.1'

gem 'acts-as-taggable-on'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'
gem 'searchkick'
gem 'rails',  '5.0.1'
gem 'mysql2', '0.4.2'
gem 'puma',   '3.0'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'jbuilder', '~> 2.5'
gem 'hamlit'
gem 'rails-i18n'
gem 'devise-i18n'
gem 'carrierwave'
gem 'cloudinary'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-vkontakte'
gem 'therubyracer'
gem 'devise'
gem 'koala'
gem 'rails4-autocomplete'
gem 'kaminari'
gem 'ckeditor'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rubocop'
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
