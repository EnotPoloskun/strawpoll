module Strawpoll
  class Poll
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

      response = API.create(title: title, options: options, multi: multi, permissive: permissive)

      self.id = response[:id]

      self
    end

    def reload
      raise ArgumentError.new('You must specify id') unless id

      API.get(id).tap do |response|
        self.title = response[:title]
        self.multi = response[:multi]
        self.permissive = response[:permissive]
        self.options = response[:options]
        self.votes = response[:votes]
      end

      self
    end

    def votes_count(option = nil)
      result = options.inject({}) do |result, option|
        result[option] = votes[options.index(option)] || 0

        result
      end

      option.nil? ? result : result[option]
    end

    def vote(option)
      option = option.to_s
      raise ArgumentError.new('Wrong option') unless options.include?(option)

      API.patch(id, { votes: [options.index(option)] })

      reload
    end

    class << self
      def get(id)
        raise ArgumentError.new('You must specify id') unless id

        response = API.get(id)

        self.new(response.merge(id: id))
      end

      def create(options = {})
        self.new(options).create
      end
    end
  end
end
