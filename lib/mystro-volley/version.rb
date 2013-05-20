unless defined?(Mystro::Volley::Version)
  # MystroVolley::Version conflicts with Version model
  module Mystro
    module Volley
      module Version
        MAJOR  = 0
        MINOR  = 1
        TINY   = 0
        TAG    = "rc2"
        STRING = [MAJOR, MINOR, TINY, TAG].compact.join('.')
      end
    end
  end
end
