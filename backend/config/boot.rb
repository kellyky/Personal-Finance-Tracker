ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.

if ENV["RAILS_ENV"] == "test" || (ENV["RAILS_ENV"].nil? && ARGV.any? { |arg| arg == "test" || arg == "t" })
  require "simplecov"
  SimpleCov.start "rails"
end

require "bootsnap/setup" # Speed up boot time by caching expensive operations.

