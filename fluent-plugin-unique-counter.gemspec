# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-unique-counter"
  spec.version       = "0.1.3"
  spec.authors       = ["Keiji Matsuzaki", "Takesato"]
  spec.email         = ["futoase@gmail.com"]
  spec.summary       = %q{fluentd unique counter plugin.}
  spec.description   = %q{This plugin is use of count up to unique attribute.}
  spec.homepage      = "http://aiming.github.io/fluent-plugin-unique-counter/"
  spec.license       = "Apache License v2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "timecop"

  spec.add_dependency "fluentd"
end
