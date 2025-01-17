# -*- ruby -*-
_VERSION = "0.4.3"
date = %w$Date:: 2015-06-13 11:35:25 +0900#$[1]

Gem::Specification.new do |s|
  s.name = "io-console"
  s.version = _VERSION
  s.date = date
  s.summary = "Console interface"
  s.email = "nobu@ruby-lang.org"
  s.description = "add console capabilities to IO instances."
  s.required_ruby_version = ">= 2.0.0"
  s.homepage = "http://www.ruby-lang.org"
  s.authors = ["Nobu Nakada"]
  s.require_path = %[lib]
  s.files = %w[console.c extconf.rb lib/console/size.rb]
  s.extensions = %w[extconf.rb]
  s.licenses = "ruby"
  s.cert_chain  = %w[certs/nobu.pem]
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
