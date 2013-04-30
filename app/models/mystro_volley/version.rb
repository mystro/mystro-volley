module MystroVolley
  class Version
    include Mongoid::Document
    include Mongoid::Timestamps

    belongs_to :branch, class_name: 'MystroVolley::Branch'

    field :name, type: String
    field :files, type: Array
    field :timestamp, type: DateTime
    field :latest, type: Boolean

    def project
      branch ? branch.project : nil
    end

    def to_s
      "#{branch.to_s}:#{name}" #" timestamp:#{timestamp} files:#{files ? files.count : 0}"
    end
  end
end