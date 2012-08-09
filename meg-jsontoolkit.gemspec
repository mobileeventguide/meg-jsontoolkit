# -*- encoding: utf-8 -*-
require File.expand_path('../lib/meg-jsontoolkit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marc Schuba"]
  gem.email         = ["marc.schuba@mobileeventguide.de"]
  gem.description   = %q{Assorted tools for generating MEG XF format in JSON}
  gem.summary       = %q{Base64-Encoding of assets with mime-type in the header, relations (has-manys) for MEGv2.0, etc.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "meg-jsontoolkit"
  gem.require_paths = ["lib"]
  gem.version       = Meg::Jsontoolkit::VERSION
end
