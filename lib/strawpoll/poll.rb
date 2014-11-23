module Strawpoll
  class Poll
    API_PATH = "http://strawpoll.me/api/v2/polls"

    attr_accessor :id, :title, :options, :votes, :multi, :permissive

    def initialize(options = {})
      options.symbolize_keys!

      options = {
        multi: false,
        permissive: false,
        votes: [],
      }.merge(options)

      [:id, :title, :options, :votes, :multi, :permissive].each do |attribute|
        self.send("#{attribute}=", options[attribute])
      end

      self
    end

    def create
      [:title, :options].each do |attribute|
        raise ArgumentError.new('Attributes title and options are required') unless self.send(attribute)
      end

      Net::HTTP.post_form(URI(API_PATH), title: title, options: options, multi: multi, permissive: permissive).tap do |response|
        parsed_body = JSON.parse(response.body)

        raise Strawpoll::APIError.new(parsed_body["error"]) if parsed_body["error"]

        self.id = parsed_body["id"]
      end

      self
    end

    class << self
      def get(id)
        raise ArgumentError.new('You must specify id') unless id

        response = JSON.parse(Net::HTTP.get(URI("#{API_PATH}/#{id}")))
        raise Strawpoll::APIError.new(response["error"]) if response["error"]

        self.new(response.merge(id: id))
      end

      def create(options = {})
        self.new(options).create
      end
    end
  end
end
