# Rankle

Rankle provides multi-resource ranking.  It uses a separate join table rather than a resource specific position column.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rankle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rankle

## Default Behavior

Simply including Rankle is intended to be ineffectual:

```ruby
class Fruit < ActiveRecord::Base
end

Fruit.all.to_a == Fruit.rank.all.to_a # true
```

However, new records will respond to position:

```ruby
apple  = Fruit.create!
orange = Fruit.create!

apple.position  # 0
orange.position # 1
```

## Simple Usage

You can assign an explicit ranking in several ways.  The position attribute can be set directly:

```ruby
apple.update_attribute :position, 1

apple.position  # 1
orange.position # 0
```

When called with an integer, the rank method will assign the position:

```ruby
apple.rank 0

apple.position  # 0
orange.position # 1
```

You can declare a proc to maintain a functional position ranking:

```ruby
class Fruit < ActiveRecord::Base
  ranks ->(a, b) { a.name < b.name }
end

Fruit.create! name: 'apple'
Fruit.create! name: 'orange'
Fruit.create! name: 'banana'

Fruit.rank.all.map(&:name) # ['apple', 'banana', 'orange']
```

## Multiple Resources

Passing a symbol to the rank method with a position will update the position to that named rank:

```ruby
class Fruit < ActiveRecord::Base
end

class Vegetable < ActiveRecord::Base
end

apple = Fruit.create!
carrot = Vegetable.create!

apple.rank :produce, 0
carrot.rank :produce, 1

apple.position # 0
carrot.position # 0

apple.position :produce # 0
carrot.position :produce # 1
```

Passing a symbol to the ranks method will register the resource to that ranking.  This will automatically assign the
default position to new records within the shared ranking:

```ruby
class Fruit
  ranks :produce
end

Class Vegetable
  ranks :produce
end

apple = Fruit.create!
carrot = Vegetable.create!

apple.position # 0
carrot.position # 0

apple.position :produce # 0
carrot.position :produce # 1
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rankle/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
