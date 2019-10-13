
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "project_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "project_cli"
  spec.version       = ProjectCli::VERSION
  spec.authors       = ["'chic-page-6502'"]
  spec.email         = ["'zacharytq@gmail.com'"]

  spec.summary       = "Just a cli to find mountain bike trails."
  
  spec.homepage      = "https://github.com/zacharytq/sfl_mtn_bike.git"
  spec.license       = "MIT"

 

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry", "~> 0.10.3"
  
  spec.add_dependency "nokogiri"
end
