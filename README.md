# Graphsrb

Graphsrb allows to create simple directed and undirected graphs. Basic operations allows easily implement graph algorithms

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphsrb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install graphsrb

## Usage
```
require 'graphsrb'
include Graphsrb
```
#### Creating graphs
Each vertex of a graph must have a unique id (a positive integer). Each edge is characterized by a pair of vertices `initial_vertex` and `terminal_vertex`.      
```
#(undirected) complete graph on 3 vertices
Graph.new(edges:edges)
graph = Graph.new(edges:[[1,2],[2,3],[3,1]])
graph.vertex_count # => 3
graph.edge_count # => 3
graph.edge?(1,3) # => true
```
```
#directed graph on 3 vertices
graph = Digraph.new(edges:[[1,2],[2,3],[3,1]])
graph = Graph.new(edges:[[1,2],[2,3],[3,1]])
graph.vertex_count # => 3
graph.edge_count # => 3
graph.edge?(1,3) # => false
```




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/graphsrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Graphsrb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/graphsrb/blob/master/CODE_OF_CONDUCT.md).
