source 'http://ruby.taobao.org'
gem 'thin'
# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '~> 3.2', :require => 'active_record'
gem 'mysql2'

#cache
gem "second_level_cache", :git => "git://github.com/csdn-dev/second_level_cache.git"

# pipeline
gem 'sprockets'
gem 'sprockets-helpers', :git => 'git@github.com:omamori/sprockets-helpers.git'

# Test requirements

# Padrino Stable Gem
gem 'padrino', '0.11.3'

#auth
gem 'omniauth-identity'

gem 'will_paginate', :require => ['will_paginate/active_record', 'will_paginate/view_helpers/sinatra']

group :development, :test do
    gem 'coffee-script'
    gem 'sass'
    gem 'uglifier'
    gem 'pry-padrino'
end

# Test requirements
group :test do
    gem 'minitest', "~>2.6.0", :require => "minitest/autorun"
    gem 'rack-test', :require => "rack/test"
    gem 'factory_girl'
    gem 'database_cleaner'
end
