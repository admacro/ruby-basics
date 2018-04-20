# coding: utf-8
Gem::Specification.new do |spec|
  # required attributes
  spec.name = "hello"  
  spec.summary = spec.description
  spec.version = '0.1.0'
  spec.files = ["lib/hello.rb"]

  # recommanded attributes
  spec.author = "James Ni" # also authors (array)
  spec.description = "Hello"
  spec.email = "you@guess.com"
  spec.homepage = "http://https://github.com/admacro/ruby-basics/hello_gem/"
  spec.license = "MIT" # also licenses (array)
  spec.metadata = { "additional_attr" => "Hi"}

  # optional (more at http://guides.rubygems.org/specification-reference/)
  spec.add_development_dependency "bundler", "~> 1.0"
  spec.require_paths = %w(lib)
  spec.required_ruby_version = ">= 1.8.7"
  spec.required_rubygems_version = ">= 1.3.5"
end
