# Strawpoll

With the help of this gem you can manipulate with polls of strawpoll.me service. You can get, create polls and also vote.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'strawpoll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install strawpoll

## Usage

You can create poll this way:

```ruby
Strawpoll::Poll.create(title: 'Do you like this gem?', options: ['Yes', 'No'])
=> #<Strawpoll::Poll:0x007fb8e4162f70 @id=3057139, @title="Do you like this gem?", @options=["Yes", "No"], @votes=[], @multi=false, @permissive=false>
```

and this way:

```ruby
poll = Strawpoll::Poll.new(title: 'Do you like this gem?', options: ["Yes", "No"])
poll.create
=> #<Strawpoll::Poll:0x007fb8e40a2dd8 @id=3057160, @title="Do you like this gem?", @options=["Yes", "No"], @votes=[], @multi=false, @permissive=false>
```

Also to reload poll(to update votes):

```ruby
poll.reload
=> #<Strawpoll::Poll:0x007fb8e40a2dd8 @id=3057160, @title="Do you like this gem?", @options=["Yes", "No"], @votes=[0, 0], @multi="false", @permissive="false">
```

You can get existing poll:

```ruby
Strawpoll::Poll.get(3057160)
=> #<Strawpoll::Poll:0x007fb8e70519d0 @id=3057160, @title="Do you like this gem?", @options=["Yes", "No"], @votes=[0, 0], @multi="false", @permissive="false">
```

You can vote and get votes count:

```ruby
poll.vote('Yes')
=> #<Strawpoll::Poll:0x007fb8e40a2dd8 @id=3057160, @title="Do you like this gem?", @options=["Yes", "No"], @votes=[1, 0], @multi="false", @permissive="false">
poll.votes_count
=> {"Yes"=>1, "No"=>0}
poll.votes_count("Yes")
=> 1
```

## Contributing

1. Fork it ( https://github.com/enotpoloskun/strawpoll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
