puts "nakaearth template"
run 'rm public/index.html'
run 'rm public/images/rails.png'

puts "Gemfile edit!!"
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'json'
gem 'kaminari'
gem 'dalli'
gem 'whenever'
gem_group :development, :test do
  gem 'rspec-rails'
  gem 'rake_shared_context'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  # fixtureの代わり
  gem "factory_girl_rails"
#  gem 'shoulda-matchers', require: false
  gem 'shoulda-matchers'
  gem 'json_expressions'
  # テスト環境のテーブルをきれいにする
  gem 'database_rewinder'
end
gem_group :development do
# Railsコンソールの多機能版
  gem 'pry-rails'

  # pryの入力に色付け
#  gem 'pry-coolline'

  # デバッカー
  gem 'pry-byebug'

  # Pryでの便利コマンド
  gem 'pry-doc'

  # pryの色付けをしてくれる
  gem 'awesome_print'

  gem 'spring'

  # profile gem
  gem 'speed_gun'
  gem 'msgpack',  '~> 0.5.8'

  gem 'guard'
  gem 'guard-rspec', ' ~> 0.4.2'
  gem 'guard-spring' 
end
# run bundle install
run_bundle

# rspec
puts "--file generate.--"
puts "rspec file generate"
generate 'rspec:install' 
remove_dir 'test'
# guard
puts "guard file init"
run "bundle exec guard init"

#use bootstrapt
use_bootstrap = if yes?('Use Bootstrapt?')
                  uncomment_lines 'Gemfile', "gem 'therubyracer'"
                  gem 'less-rails'
                  gem 'twitter-bootstrap-rails', :gti => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
                  true
                else 
                  false
                end
if use_bootstrap
  generate 'bootstrap:install', 'less'
  if yes?('Use responsive layout?')
    generate 'bootstrap:layout', 'application fluid'
  else
    generate 'bootstrap:layout', 'application fixed'
  end
end

puts "git init!!"
git :init
git :add=>'.'
git :commit=>"-m'initial commit'"

puts "done"
