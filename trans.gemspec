# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trans/version'
require 'rake'

Gem::Specification.new do |gem|
  gem.name          = "trans"
  gem.version       = Trans::VERSION
  gem.authors       = ["shiren1118"]
  gem.email         = ["shiren1118@126.com"]
  gem.description   = %q{convert markdown to html with i5ting_ztree_toc plugin}
  gem.summary       = %q{convert markdown to html with i5ting_ztree_toc plugin}
  gem.homepage      = "http://ruby-china.org/topics/17028"
  gem.files         = FileList['lib/**/*.rb',
                        'bin/*',
                        'template/**/**/**',
                        'test/**/*'].to_a
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "redcarpet"
  gem.add_dependency "pygments.rb"
end
