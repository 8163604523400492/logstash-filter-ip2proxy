Gem::Specification.new do |s|

  s.name            = 'logstash-filter-ip2proxy'
  s.version         = '1.0.0'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "Logstash filter IP2Proxy"
  s.description     = "IP2Proxy filter plugin for Logstash enables Logstash's users to query an IP address if it was being used as open proxy, web proxy, VPN servers and TOR exits. It also appends country, state, city and ISP information of the server."
  s.authors         = ["IP2Location"]
  s.email           = 'support@ip2location.com'
  s.homepage        = "https://www.ip2location.com"
  s.require_paths   = ["lib", "vendor/jar-dependencies"]

  # Files
  s.files = Dir["lib/**/*",'spec/**/*',"vendor/**/*","vendor/jar-dependencies/**/*.jar","*.gemspec","*.md","Gemfile","LICENSE"]

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_development_dependency "logstash-devutils"
end
