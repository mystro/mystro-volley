require_dependency "mystro_volley/application_controller"

module MystroVolley
  class VersionsController < ApplicationController
    # GET /versions
    # GET /versions.json
    def index
      @versions = Version.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @versions }
      end
    end
  
    # GET /versions/1
    # GET /versions/1.json
    def show
      @version = Version.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @version.files.map {|e| {name: e, _id:"blarg"}} }
      end
    end

    # GET /versions/1/deploy
    def deploy
      @version = Version.find(params[:id])
      render "deploy", layout: false
    end

    # POST /versions/1/queue
    def queue
      @version = Version.find(params[:id])
      @environment = Environment.find(params[:environment])
      @role = Role.find(params[:role])
      j = Jobs::Volley::Deploy.create(data: {version: @version.to_s, environment: @environment.name, organization: current_user.organization, force: params[:force] == 1, role: @role.name})
      j.enqueue
      render status: :ok, json: {errors: false}
    rescue => e
      render status: :bad_request, json: {errors: true, message: e.message}
    end
  
    ## GET /versions/new
    ## GET /versions/new.json
    #def new
    #  @version = Version.new
    #
    #  respond_to do |format|
    #    format.html # new.html.erb
    #    format.json { render json: @version }
    #  end
    #end
    #
    ## GET /versions/1/edit
    #def edit
    #  @version = Version.find(params[:id])
    #end
    #
    ## POST /versions
    ## POST /versions.json
    #def create
    #  @version = Version.new(params[:version])
    #
    #  respond_to do |format|
    #    if @version.save
    #      format.html { redirect_to @version, notice: 'Version was successfully created.' }
    #      format.json { render json: @version, status: :created, location: @version }
    #    else
    #      format.html { render action: "new" }
    #      format.json { render json: @version.errors, status: :unprocessable_entity }
    #    end
    #  end
    #end
    #
    ## PUT /versions/1
    ## PUT /versions/1.json
    #def update
    #  @version = Version.find(params[:id])
    #
    #  respond_to do |format|
    #    if @version.update_attributes(params[:version])
    #      format.html { redirect_to @version, notice: 'Version was successfully updated.' }
    #      format.json { head :no_content }
    #    else
    #      format.html { render action: "edit" }
    #      format.json { render json: @version.errors, status: :unprocessable_entity }
    #    end
    #  end
    #end
  
    # DELETE /versions/1
    # DELETE /versions/1.json
    def destroy
      @version = Version.find(params[:id])
      Jobs::Volley::Destroy::Version.create(data: {id: @version.id, class: "MystroVolley::Version"}).enqueue

      respond_to do |format|
        format.html { redirect_to versions_url }
        format.json { head :no_content }
      end
    end
  end
end
