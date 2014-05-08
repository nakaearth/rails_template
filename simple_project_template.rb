puts "nakaearth template"
run 'rm public/index.html'
run 'rm public/images/rails.png'

puts "Gemfile edit!!"
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

  gem 'guard'
  gem 'guard-rspec', ' ~> 0.4.2'
  gem 'guard-spring' 
end

# APサーバ
gem 'puma'

# run bundle install
#run_bundle
run "bundle install --path vendor/bundle --without production"

# rspec
puts "--file generate.--"
puts "rspec file generate"
generate 'rspec:install' 
remove_dir 'test'

# guard
puts "guard file init"
run "bundle exec guard init"

# config setting
application do
  %Q{
    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.test_framework  :rspec, :fixture => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.view_specs true
      g.controller_specs true
      g.routing_specs true
      g.helper_specs true
      g.request_specs true
      g.assets true
      g.helper true
    end
  }
end

environment 'config.server_static_assets=true', env: 'production'

puts "git init!!"
git :init
git :add=>'.'
git :commit=>"-m'initial commit'"

puts "done"
