# easy_map_tiles
Generate simple tiles from google maps that you can use for backgrounds or previews.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_map_tiles'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_map_tiles

## Example

[view example output](https://rawgit.com/naema/easy_map_tiles/blob/master/test.html)

## Usage

```ruby
zoom_levels = [7,8,9,10]
puts EasyMapTiles.tile_div(39.915036, 116.404996, zoom_levels, satellite: false, marker: true)
```

## Contributing

1. Fork it ( https://github.com/naema/easy_map_tiles/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
