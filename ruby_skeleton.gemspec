# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'ruby_skeleton/version'

Gem::Specification.new do |s|
  s.name = 'ruby-skeleton'
  s.version = NAME::VERSION
  s.authors = ['Alexander Reitzel']
  s.email = ['funtimecoding@gmail.com']
  s.licenses = ['MIT']
  s.homepage = ''
  s.summary = 'TODO: Write a gem summary'
  s.description = 'TODO: Write a gem description'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split(
    "\n"
  ).map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
