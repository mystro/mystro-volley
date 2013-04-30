module MystroVolley
  class Project
    include Mongoid::Document
    include Mongoid::Timestamps

    has_many :branches, class_name: 'MystroVolley::Branch'

    field :name, type: String

    def to_s
      name
    end
  end
end
