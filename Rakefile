require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'sprockets/../rake/sprocketstask'

require File.expand_path('../config/sprockets', __FILE__)
PadrinoTasks.use(:database)
PadrinoTasks.use(:activerecord)
PadrinoTasks.init

SPROCKETS.css_compressor = :sass
SPROCKETS.js_compressor = :uglifier

Rake::SprocketsTask.new do |t|
    manifest_path = File.expand_path('../public/assets/manifest.json', __FILE__)
    t.environment = SPROCKETS
    t.output      = File.expand_path('../public/assets', __FILE__)
    t.manifest    = Sprockets::Manifest.new(SPROCKETS, manifest_path)
    t.assets      = %w{app.js app.css}
end