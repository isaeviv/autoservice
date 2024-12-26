class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[ show edit update destroy ]

  # GET /workspaces or /workspaces.json
  def index
    @workspaces = current_user.workspaces
  end

  # GET /workspaces/1 or /workspaces/1.json
  def show
    @tasks = @workspace.tasks
    @projects = @workspace.projects
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def workspace_params
      params.expect(workspace: [ :name, :description, :user_id ])
    end
end
