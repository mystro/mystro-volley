require_dependency "mystro_volley/application_controller"
class MystroVolley::HomeController < ApplicationController
  include MystroVolley::ApplicationHelper

  def index
    #@projects = MystroVolley::Project.all
    @myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
    render "mystro_volley/versions/index"
  end

  def browser
    @projects = MystroVolley::Project.all
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
                return render "mystro_volley/versions/show"
              else
                flash.now[:error] = "version #{v} not found"
                return render "mystro_volley/branches/show"
              end
            else
              return render "mystro_volley/branches/show"
            end
          else
            flash.now[:error] = "branch #{b} not found"
            return render "mystro_volley/projects/show"
          end
        else
          return render "mystro_volley/projects/show"
        end
      else
        #@myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
        #render "mystro_volley/versions/index"
        flash.now[:error] = "project #{p} not found"
      end
    else
      @myversions = MystroVolley::Version.desc(:timestamp).where(latest: true)
      render "mystro_volley/versions/index"
    end
  end
end
