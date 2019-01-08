
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "script_tools/version"

Gem::Specification.new do |spec|
  spec.name          = "script_tools"
  spec.version       = ScriptTools::VERSION
  spec.authors       = ["Misty De Meo"]
  spec.email         = ["mistydemeo@gmail.com"]

  spec.summary       = %q{Script tools for use with Lunar: Silver Star Story}
  spec.description   = %q{Script tools for use with Lunar: Silver Star Story}
  spec.homepage      = "https://github.com/studio-lucia/sss_script_tools"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
