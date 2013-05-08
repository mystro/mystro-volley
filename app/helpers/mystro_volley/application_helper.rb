module MystroVolley
  module ApplicationHelper
    def path_helper(o)
      case o.class
        when MystroVolley::Project then root_path + "#{o.name}"
        when MystroVolley::Branch then root_path + "#{o.project.name}/#{o.name}"
        when MystroVolley::Version then root_path + "#{o.project.name}/#{o.branch.name}/#{o.name}"
        else root_path
      end
    rescue => e
      flash.now[:error] = "could not find path for #{o}"
      root_path
    end
  end
end
