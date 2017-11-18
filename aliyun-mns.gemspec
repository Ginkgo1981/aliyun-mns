# -*- encoding: utf-8 -*-
# stub: aliyun-mns 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "aliyun-mns"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["mgampkay", "skinnyworm"]
  s.date = "2015-12-13"
  s.description = "Non-official SDK for Aliyun MNS"
  s.email = ["mgampkay@gmail.com", "askinnyworm@gmail.com"]
  s.executables = ["mns"]
  s.files = [".gitignore", ".travis.yml", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "aliyun-mns.gemspec", "bin/mns", "lib/aliyun/mns.rb", "lib/aliyun/mns/cli.rb", "lib/aliyun/mns/message.rb", "lib/aliyun/mns/queue.rb", "lib/aliyun/mns/request.rb", "lib/aliyun/mns/version.rb", "spec/lib/aliyun/mns/message_spec.rb", "spec/lib/aliyun/mns/queue_spec.rb", "spec/lib/aliyun/mns/request_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "https://github.com/mgampkay/aliyun-mns"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Ruby SDK for Aliyun mns (non-official)"
  s.test_files = ["spec/lib/aliyun/mns/message_spec.rb", "spec/lib/aliyun/mns/queue_spec.rb", "spec/lib/aliyun/mns/request_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.6"])
      s.add_runtime_dependency(%q<activesupport>, [">= 4.1"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.6"])
      s.add_dependency(%q<activesupport>, [">= 4.1"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.6"])
    s.add_dependency(%q<activesupport>, [">= 4.1"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
