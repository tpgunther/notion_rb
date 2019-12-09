# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notion_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'notion_rb'
  spec.version       = NotionRb::VERSION
  spec.authors       = ['Tomas Gunther']
  spec.email         = ['tpgunther@uc.cl']

  spec.summary       = 'Unoficial integration with Notion'
  spec.description   = ''
  spec.homepage      = 'https://www.github.com/tpgunther/notion-rb'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'mechanize'

  spec.add_development_dependency 'bundler', '~> 1.17.0'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'single_cov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
