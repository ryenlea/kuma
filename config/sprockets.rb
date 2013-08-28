#require 'sprockets'
SPROCKETS = Sprockets::Environment.new(File.expand_path('../../', __FILE__))

SPROCKETS.append_path File.expand_path('../../assets/stylesheets', __FILE__)
SPROCKETS.append_path File.expand_path('../../assets/javascripts', __FILE__)
SPROCKETS.append_path File.expand_path('../../assets/images',      __FILE__)
SPROCKETS.append_path File.expand_path('../../assets/vendor/stylesheets', __FILE__)
SPROCKETS.append_path File.expand_path('../../assets/vendor/javascripts', __FILE__)
SPROCKETS.append_path File.expand_path('../../assets/vendor/images',      __FILE__)