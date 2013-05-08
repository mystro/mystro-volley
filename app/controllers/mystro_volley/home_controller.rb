require_dependency "mystro_volley/application_controller"
class MystroVolley::HomeController < ApplicationController
  include MystroVolley::ApplicationHelper

  def index
    @myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
    render "mystro_volley/versions/index"
  end

  def show
    p = params[:project]
    b = params[:branch]
    v = params[:version]

    if p
      @project = MystroVolley::Project.where(name: p).first

      if @project
        if b
          @branch = @project.branches.where(name: b).first
          if @branch
            if v
              @version = @branch.versions.where(name: v).first
              if @version
                logger.info "VERSION: #{@version.class}"
                return render "mystro_volley/versions/show"
              else
                return render "mystro_volley/branches/show"
              end
            else
              return render "mystro_volley/branches/show"
            end
          else
            return render "mystro_volley/projects/show"
          end
        else
          return render "mystro_volley/projects/show"
        end
      else
        @myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
        render "mystro_volley/versions/index"
      end
    else
      @myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
      render "mystro_volley/versions/index"
    end
  end
end