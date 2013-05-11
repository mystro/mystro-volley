module MystroVolley
  class Install
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :compute, class_name: "Compute"
    belongs_to :version, class_name: "MystroVolley::Version"
  end
end
