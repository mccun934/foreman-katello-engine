Gem::Specification.new do |s|
  s.name = "foreman-katello-engine"
  s.version = "0.0.16"

  s.authors = ["Katello"]
  s.date = "2013-03-04"
  s.description = "Katello specific parts of Foreman"
  s.email = "katello-devel@redhat.com"
  s.files = %w(foreman-katello-engine.gemspec Gemfile LICENSE Rakefile README.md)
  s.files += Dir["app/**/*"]
  s.files += Dir["config/**/*.rb"]
  s.files += Dir["db/**/*.rb"]
  s.files += Dir["lib/**/*.rb"]
  s.files += Dir["test/test_helper.rb"]
  s.files += Dir["test/lib/**/*.rb"]
  s.files += Dir["test/functional/**/*.rb"]
  s.homepage = "http://github.com/katello/foreman-katello-engine"
  s.licenses = ["GPL-3"]
  s.require_paths = ["lib"]
  s.add_dependency "katello_api"
  s.add_dependency "deface", "~> 0.7.2"
  s.summary = "Katello specific parts of Foreman"
end
