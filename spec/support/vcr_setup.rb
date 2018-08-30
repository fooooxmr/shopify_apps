require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = Rails.root.join('data/vcr_rspec').to_s
  c.default_cassette_options = {
      serialize_with: :json,

      # NOTE: please do not set to :new_episodes.
      # Any new http interactions should be manually checked,
      # as they could be expected or not, and based on that, decision
      # should be made: re-record cassette or fix test.
      # :new_episodes mode prevents from this flow,
      # as it will cause new requests
      # to be silently recorded into cassette (think about CI for example).
      record: :once,

      match_requests_on: [:method, :uri, :body],
  }

  c.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding.name == 'ASCII-8BIT' ||
        !http_message.body.valid_encoding?
  end

  # all localhost connections is either database
  c.ignore_localhost = true

  c.configure_rspec_metadata!

  # uncomment to see what vcr does
  c.debug_logger = STDERR
end