# acts_as_starable

This gem is based on the structure, functionality, and features of the [acts_as_follower](https://github.com/tcocca/acts_as_follower) gem. It provides the files and methods necessary to enable one ActiveRecord model to star, or to be starred, by another.

## Installation

Add this line to your Gemfile:

```ruby
gem 'randomuser'
```

And then execute:

```bash
$ bundle
```

Run the generator:

```bash
$ rails generate acts_as_starable
```

This will generate a migration file as well as a model called Star.

Run the migration:

```bash
$ rails db:migrate
```

## Usage

There are three parts to enabling and using this gem. First you have to enable the required functionality on the models that you would like to be able to star other models or those that can be starred. After that you can use the methods defined in the `ActsAsStarable::Starer` module to work with a model that is able to star other models; or those defined in the `ActsAsStarable::Starable` module to work with models that are going to be starred by other models.

### Setup

To enable one model to star other models, add the `acts_as_starer` method to that model:

```ruby
class User < ActiveRecord::Base
  ...
  acts_as_starer
  ...
end
```

To enable one model to be starred by other models, add the `acts_as_starable` method to that model:

```ruby
class Band < ActiveRecord::Base
  ...
  acts_as_starable
  ...
end
```

Once this functionality has been defined you can use the methods in each module to query your models for the state of the stars in your application.

### acts_as_starer methods

To have one object star another:

```ruby
# grab a starer and a starable
user = User.first
band = Band.first

# Create a record for the user as the starer and the band as the starable
user.star(band)
```

To remove the previously created star:

```ruby
user.unstar(band)
```

To find out if a starer model has starred a starable model:

```ruby
user.starred?(band)
```

To get a count of stars created by a starer model:

```ruby
user.stars_count
```

To get a collection of star objects from the Star table by type:

```ruby
user.stars_by_type('Band')

# also accepts ActiveRecord options
user.stars_by_type('Band', limit: 5)
```

To get a collection of the actual starable model records by type:

```ruby
user.starred_by_type('Band')

# also accepts ActiveRecord options
user.starred_by_type('Band', limit: 5)
```

To get a collection of all star objects from the Star table:

```ruby
user.all_stars

# also accepts ActiveRecord options
user.all_stars(limit: 5)
```

To get a collection of all of the actual starable model records:

```ruby
user.all_starred

# also accepts ActiveRecord options
user.all_starred(limit: 5)
```

### acts_as_starable methods

To find out if a starable model has been starred by a starer model:

```ruby
band.starred_by?(user)
```

To get a count of the number of times a starable model has been starred:

```ruby
band.starings_count
```

To get a collection of star objects from the Star table by type:

```ruby
band.starings_by_type('User')

# also accepts ActiveRecord options
band.starings_by_type('User', limit: 5)
```

To get a collection of the actual starer model records by type:

```ruby
band.starers_by_type('User')

# also accepts ActiveRecord options
band.starers_by_type('User', limit: 5)
```

To get a collection of all star objects from the Star table:

```ruby
band.all_starings

# also accepts ActiveRecord options
band.all_starings(limit: 5)
```

To get a collection of all of the actual starer model records:

```ruby
band.all_starers

# also accepts ActiveRecord options
band.all_starers(limit: 5)
```

## Tests

Testing works as usual:

```bash
git clone https://github.com/littlstar/acts_as_starable.git
cd acts_as_starable
bundle install
rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Attribution

I can only take a small amount of credit for the creation of this gem. Its structure, functionality, and features are based in large part on the excellent work of @tcocca (and other [contributors](https://github.com/tcocca/acts_as_follower#contributers)) on the [acts_as_follower](https://github.com/tcocca/acts_as_follower) gem.
