$: << File.expand_path(File.dirname(__FILE__))
require 'json'
require 'base64'
require 'net/http'
require 'net/https'

ACCESS_TOKEN_URL = 'https://github.com/settings/applications#personal-access-tokens'.freeze

def get uri, headers
  http = Net::HTTP.new uri.host, uri.port
  http.use_ssl = true if uri.scheme == 'https'
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  path = uri.path
  path += '?' + uri.query if uri.query

  request = Net::HTTP::Get.new path, headers
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

def basic_header token
  {
    'Authorization' => 'Basic ' + Base64.encode64("#{token}:x-oauth-basic").gsub("\n", ''),
    'User-Agent' => 'Github-Notifier'
  }
end

def iso8601 time
  time.utc.strftime('%FT%TZ')
end

def check_system
  if `uname`.strip != 'Darwin'
    $stderr.puts 'Github Notifier can only works on Mac OS X'
    exit(-2)
  end

  if `sw_vers -productVersion`.strip.to_f < 10.8
    $stderr.puts 'Github Notifier can only works on Mac OS X, at least Mountain Lion (10.8)'
    $stderr.puts 'Please upgrade your system and retry'
    exit(-1)
  end

  if !`which terminal-notifier`.empty?
    $terminal_notifier = 'terminal-notifier'
  elsif File.executable? '/usr/local/bin/terminal-notifier'
    $terminal_notifier = '/usr/local/bin/terminal-notifier'
  end

  unless $terminal_notifier
    $stderr.puts 'Github Notifier depends on terminal-notifier'
    $stderr.puts 'Please run `brew install terminal-notifier` to install it and retry'
    exit(-3)
  end
end
