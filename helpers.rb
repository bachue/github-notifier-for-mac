require 'base64'
require 'json'
require 'net/http'
require 'net/https'

ACCESS_TOKEN_URL = 'https://github.com/settings/applications#personal-access-tokens'.freeze

def get uri, headers
  http = Net::HTTP.new uri.host, uri.port
  http.use_ssl = true if uri.scheme == 'https'

  request = Net::HTTP::Get.new uri.path, headers
  http.request request
end

def get_json uri, headers
  response = get uri, headers
  if response.code != '200'
    $stderr.puts 'Failed to check Github! Please check your access token and network connection!'
    exit 2
  end
  JSON.parse response.body
end

def oauth_basic_token_path
  @_oauth_basic_token_path ||= File.expand_path '~/.github_oauth_basic'
end

def timestamp_path
  @_timestamp_path ||= '/tmp/.github-notifier-last-check'
end

def basic_auth_header token
  { 'Authorization' => 'Basic ' + Base64.strict_encode64("#{token}:x-oauth-basic") }
end

def iso8601 time
  time.utc.strftime('%FT%TZ')
end
