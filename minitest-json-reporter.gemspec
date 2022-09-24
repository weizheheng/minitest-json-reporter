# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "minitest-json-reporter"
  spec.version = "0.0.0"
  spec.authors = ["Wei Zhe Heng"]
  spec.email = ["tech@weizheheng.com"]

  spec.summary = "A minitest JSON reporter plugin"
  spec.homepage = "https://github.com/weizheheng/minitest-json-reporter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/weizheheng/minitest-json-reporter"
  spec.metadata["changelog_uri"] = "https://github.com/weizheheng/minitest-json-reporter"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.add_development_dependency("debug", "~> 1.6.2")
end
