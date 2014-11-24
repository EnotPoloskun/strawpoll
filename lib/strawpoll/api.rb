module Strawpoll
  class API
    API_URI = URI("http://strawpoll.me/")

    class << self
      def http
        @http ||= Net::HTTP.new(API_URI.host, API_URI.port)
      end

      def get(id)
        perform("/api/v2/polls/#{id}", :get).parsed_body.symbolize_keys
      end

      def create(params)
        perform("/api/v2/polls", :post, params).parsed_body.symbolize_keys
      end

      def patch(id, params)
        perform("/api/v2/polls/#{id}", :patch, params).parsed_body.symbolize_keys
      end

      def perform(uri, method, params = {})
        request = case method
          when :get
            Net::HTTP::Get.new(uri)
          when :post
            Net::HTTP::Post.new(uri).tap do |request|
              request.set_form_data(params)
            end
          when :patch
            Net::HTTP::Patch.new(uri).tap do |request|
              request.body = params.to_json
              request.content_type = 'application/json'
            end
        end

        http.request(request).tap do |response|
          raise Strawpoll::API::Error.new(response.body) unless response.kind_of? Net::HTTPSuccess

          response.parsed_body = JSON.parse(response.body) rescue {}
        end
      end
    end

    class Error < Exception; end
  end
end

class Net::HTTPResponse
  attr_accessor :parsed_body
end
