# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'playfair/version'

Gem::Specification.new do |s|
  s.name         = "playfair"
  s.version      = Playfair::VERSION
  s.authors      = ["Chris Dinn"]
  s.email        = "chrisgdinn@gmail.com"
  s.homepage     = "http://github.com/chrisdinn/playfair"
  s.summary      = "A Ruby data-visualization library"

  s.files        = `git ls-files lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
