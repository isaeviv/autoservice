class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[ show edit update destroy ]
  before_action :authorize_workspace, only: %i[ show edit update destroy ]
  before_action :set_current_workspace, only: %i[ show ]
  helper_method :tasks_scope?
  helper_method :projects_scope?

  # GET /workspaces or /workspaces.json
  def index
    @workspaces = current_user.workspaces
  end

  # GET /workspaces/1 or /workspaces/1.json
  def show
    # @pagy_tasks, @tasks =    pagy(@workspace.tasks, params: { scope: :tasks }, limit: 2) if tasks_scope?
    #   @pagy_projects, @projects = pagy(@workspace.projects, params: { scope: :projects }, limit: 1) if projects_scope?
    # @projects = @workspace.projects

    respond_to do |format|
      format.html
    end
  end

  # GET /workspaces/new
  def new
    @workspace = current_user.workspaces.new
  end

  # GET /workspaces/1/edit
  def edit
  end

  # POST /workspaces or /workspaces.json
  def create
    @workspace = current_user.workspaces.new(workspace_params)
    @workspace.owner = current_user # set owner
    respond_to do |format|
      if @workspace.save
        format.html { redirect_to @workspace, notice: "Workspace was successfully created." }
        format.json { render :show, status: :created, location: @workspace }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspaces/1 or /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.html { redirect_to @workspace, notice: "Workspace was successfully updated." }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1 or /workspaces/1.json
  def destroy
    @workspace.destroy!

    respond_to do |format|
      format.html { redirect_to workspaces_path, status: :see_other, notice: "Workspace was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_current_workspace
    session[:current_workspace_id] = @workspace.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params.expect(:id))
      @parent ||= @workspace
    end

    # Only allow a list of trusted parameters through.
    def workspace_params
      params.expect(workspace: [ :name, :description, :user_id ])
    end

    def tasks_scope?
      params[:scope] == "tasks"
    end

    def projects_scope?
      params[:scope] == "projects"
    end

    def pagy_url_for(pagy, page, absolute: false)
      params = request.query_parameters.merge(pagy.vars[:page_param] => page, only_path: !absolute)
      binding.pry
      url_for(params)
    end
end
