class ProjectsController < ApplicationController
  before_action :set_workspace
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @pagy_projects, @projects = pagy(@workspace.projects)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
    @parent = @workspace
    @tasks = @project.tasks.order(created_at: :desc)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = @workspace.projects.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to [ @workspace, @project ], notice: I18n.t("flash.actions.create.notice", resource_name: Project.model_name.human) }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to [ @workspace, @project ], notice: I18n.t("flash.actions.update.notice", resource_name: Project.model_name.human) }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to workspace_projects_path(@workspace), status: :see_other, notice: I18n.t("flash.actions.destroy.notice", resource_name: Project.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @workspace.projects.find(params.expect(:id))
    end

    def set_workspace
      @workspace = Workspace.find(params.expect(:workspace_id)) || current_workspace
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :user_id)
    end
end
