require 'spec_helper'
require 'easy_map_tiles'

describe EasyMapTiles do

  it 'has a version' do
    expect(EasyMapTiles::VERSION).to match(/\d+\.\d+\.\d+/)
  end

  it 'generates google map tiles' do
    zoom_levels = [5,6,7,8,9,10]
    divs = [
      [39.915036, 116.404996, zoom_levels],
      [21.029346, 105.838938, zoom_levels],
      [52.516318, 13.402477, zoom_levels],
      [13.741276, 100.533547, zoom_levels],
      [-34.914309, -56.161885, zoom_levels],
      [54.548059, 36.287218, zoom_levels]
    ].map do |e|
      EasyMapTiles.tile_div(*e, satellite: false, marker: true)
    end
    File.write('test.html', divs.join('<br><br>'))
    puts "Check resulting easy_map_tiles in test.html"
  end

  # TODO: way more tests, including integration tests with capybara
end
