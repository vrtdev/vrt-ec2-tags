# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vrt/ec2/tags/version'

Gem::Specification.new do |spec|
  spec.name          = 'vrt-ec2-tags'
  spec.version       = Vrt::Ec2::Tags::VERSION
  spec.authors       = ['Stefan - Zipkid - Goethals']
  spec.email         = ['stefan.goehals@vrt.be']

  spec.summary       = 'Fetch EC2 tags for the requesting host only via Lambda'
  spec.description   = 'Fetch EC2 tags for the requesting host only via Lambda'
  spec.homepage      = 'https://github.com/vrtdev/vrt-ec2-tags'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
