module MystroVolley
  class Branch
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String

    has_many :versions, class_name: 'MystroVolley::Version'
    belongs_to :project, class_name: 'MystroVolley::Project'

    def to_s
      "#{project.to_s}@#{name}"
    end
  end
end