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

    class << self
      def find_by_name(name)
        (p, b, v) = name.split(/[\@\:]/)
        #puts "find_by_name: #{p} #{b} #{v}"
        project = MystroVolley::Project.where(name: p).first
        if project
          branch = project.branches.where(name: b).first
          if branch
            version = branch.versions.where(name: v).first
            return version if version
          end
        end
        nil
      end
    end
  end
end
