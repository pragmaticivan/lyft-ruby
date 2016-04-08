$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lyft'


# Record and playback Lyft API calls
require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
end

require 'webmock/rspec'
