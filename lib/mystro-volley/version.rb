unless defined?(MystroVolley::Version)
  module MystroVolley
    module Version
      MAJOR = 0
      MINOR = 1
      TINY = 0
      TAG = "rc1"
      STRING = [MAJOR, MINOR, TINY, TAG].compact.join('.')
    end
  end
end
