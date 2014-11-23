require 'active_support/core_ext/hash/keys'
require 'httparty'
require "strawpoll/version"
require "strawpoll/poll"

module Strawpoll
  # Your code goes here...

  class APIError < Exception; end
end
