class TasksController < ApplicationController
  before_action :set_parent
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @pagy_tasks, @tasks = pagy(@parent.tasks, limit: 30)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @parent.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to [ @parent, @task ], notice: I18n.t("flash.actions.create.notice", resource_name: Task.model_name.human) }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to [ @parent, @task ], notice: I18n.t("flash.actions.update.notice", resource_name: Task.model_name.human) }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to [ @parent, :tasks ], status: :see_other, notice: I18n.t("flash.actions.destroy.notice", resource_name: Task.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = @parent.tasks.find(params.expect(:id))
    end

    def set_parent
      @parent = if params[:project_id].present?
          Projects.find(params[:project_id])
      elsif params[:workspace_id].present?
          Workspace.find(params[:workspace_id])
      end
    end

    def task_params
      params.require(:task).permit(:title, :description, :project_id, :workspace_id, :user_id, :status)
    end
end
