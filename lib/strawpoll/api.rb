module Strawpoll
  class API
    API_PATH = "http://strawpoll.me/api/v2/polls"

    class << self
      def get(id)
        parsed_body = JSON.parse(Net::HTTP.get(URI("#{API_PATH}/#{id}")))
        raise Strawpoll::API::Error.new(parsed_body["error"]) if parsed_body["error"]

        parsed_body.symbolize_keys
      end

      def create(params)
        parsed_body = JSON.parse(Net::HTTP.post_form(URI(API_PATH), params).body)
        raise Strawpoll::API::Error.new(parsed_body["error"]) if parsed_body["error"]

        parsed_body.symbolize_keys
      end
    end

    class Error < Exception; end
  end
end
