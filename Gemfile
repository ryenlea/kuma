source 'http://ruby.taobao.org'
#server
gem 'thin'
#
#gem 'chinese_pinyin'
# Optional JSON codec (faster performance)
gem 'oj'

# Project requirements
gem 'rake'

# view template
gem 'erubis', '~> 2.7.0'
gem 'slim'

#db
gem 'activerecord', '~> 3.2', :require => 'active_record'
gem 'mysql2'

# cache
gem "second_level_cache", :git => "git://github.com/csdn-dev/second_level_cache.git"

# pipeline
gem 'sprockets'
gem 'sprockets-helpers', :git => 'git@github.com:omamori/sprockets-helpers.git'

# log system
gem "sentry-raven" #, :git => "https://github.com/getsentry/raven-ruby.git"
# Test requirements

# Padrino
# not use 0.11.3 , has csrf bug
gem 'padrino',  :git => 'https://github.com/padrino/padrino-framework.git', :ref => '1bf047cf274d215075162e64f8261375d6e74802'

# encrypt
gem 'bcrypt-ruby', :require => 'bcrypt'

# paging
gem 'will_paginate', :require => ['will_paginate/active_record', 'will_paginate/view_helpers/sinatra']

# photos
gem 'carrierwave', :require => ['carrierwave', 'carrierwave/orm/activerecord']
gem 'mini_magick'

gem 'sinatra-flash'

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
