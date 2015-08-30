require 'easy_map_tiles/version'

module EasyMapTiles

  class << self

    TO_DEG = Rational(180.0, Math::PI)
    TO_RAD = Rational(Math::PI, 180)
    TILE_SIZE = 256.0 # in px
    EARTH_RADIUS = 6378137.0 # in meters
    PX_PER_RAD = Rational(TILE_SIZE, (2 * Math::PI))

    # returns the pixel coordinates at the given zoom level on the world map
    def to_world_px(lat_deg, lon_deg, zoom)
      # scale the latitude via mercator projections
      # see http://en.wikipedia.org/wiki/Mercator_projection#Derivation_of_the_Mercator_projection
      lat_scaled_rad = Math.log( Math.tan( Rational(Math::PI, 4) + Rational(TO_RAD * lat_deg, 2) ))
      # https://developers.google.com/maps/documentation/javascript/examples/map-coordinates
      wx = (TILE_SIZE / 2) + PX_PER_RAD * (TO_RAD * lon_deg)
      wy = (TILE_SIZE / 2) - PX_PER_RAD * lat_scaled_rad
      tiles_count = 2**zoom
      [(wx * tiles_count).to_i, (wy * tiles_count).to_i]
    end

    def tile_url(lat_deg, lon_deg, zoom, satellite=false)
      px,py = to_world_px(lat_deg, lon_deg, zoom)
      x, y = Rational(px, TILE_SIZE).to_i, Rational(py, TILE_SIZE).to_i
      if satellite
        "https://khms#{rand(0..3)}.google.com/kh/v=131&x=#{x}&y=#{y}&z=#{zoom}"
      else
        "http://mt#{rand(0..3)}.google.com/vt/hl=en&x=#{x}&y=#{y}&z=#{zoom}"
      end
    end

    def most_fitting_zoom_level(lat_deg, lon_deg, zoom_levels)
      Array(zoom_levels).min_by do |zoom|
        to_world_px(lat_deg, lon_deg, zoom).reduce(0){|s,e| s += (TILE_SIZE / 2 - (e % TILE_SIZE)).abs}
      end
    end

    def tile_div(lat_deg, lon_deg, zoom_levels, opts={}, &block)
      satellite = opts[:satellite] || false
      marker = opts[:marker] || false
      zoom = most_fitting_zoom_level(lat_deg, lon_deg, zoom_levels)
      if marker
        px,py = to_world_px(lat_deg, lon_deg, zoom).map{|e| (e % TILE_SIZE) / TILE_SIZE}
        styles = [
          "left: #{(px*100).round(3)}%",
          "top: #{(py*100).round(3)}%"
        ]
        styles += [
          'border-radius: 50%',
          'background: rgba(255,50,50,0.9)',
          'width: 12px',
          'height: 12px',
          'position: absolute',
          'box-shadow: 0px 0px 6px 2px rgba(255,50,50,0.9)'
        ] unless opts[:marker_styles] == false
        marker_div = "<div class='emt-marker' style='#{styles.join(';')}'></div>"
      end

      styles = [
        "background-image: url(\"#{tile_url(lat_deg, lon_deg, zoom, satellite)}\")"
      ]
      styles += [
        'background-size: cover',
        'position: relative',
        'display: inline-block',
        'width: 256px',
        'height: 256px'
      ] unless opts[:tile_styles] == false
      "<div class='emt-tile' style='#{styles.join(';')}'>#{marker_div}#{yield if block_given?}</div>"
    end
  end
end
