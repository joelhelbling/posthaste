
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "posthaste/version"

Gem::Specification.new do |spec|
  spec.name          = "posthaste"
  spec.version       = Posthaste::VERSION
  spec.authors       = ["Joel Helbling"]
  spec.email         = ["joel@joelhelbling.com"]

  spec.summary       = %q{HTTP API testing/validation toolkit.}
  spec.description   = %q{What if Postman permitted your collection of specs to be saved as file artifacts under version control?}
  spec.homepage      = "https://github.com/joelhelbling/posthaste"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-given", "~> 3.0"
  spec.add_development_dependency "fakefs", "~> 0.14"
end
