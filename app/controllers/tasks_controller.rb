class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index

    @status = params[:status]
    @search_name = params[:search_name]
    @priority = params[:priority]
    @label = params[:labels]

    @tasks = current_user.tasks

    @tasks = @tasks.search_ambiguous(@search_name) if @search_name

    @tasks = @tasks.status_index(params[:status]) if params[:status].present?
    @tasks = @tasks.priority_index(params[:priority]) if params[:priority].present?
    @tasks = @tasks.search_label(params[:labels].to_i) if params[:labels].present?

    case params[:name]
    when "sort_time"
      @tasks = @tasks.order_time
    when 'sort_update'
      @tasks = @tasks.order_update
    when 'sort_priority'
      @tasks = @tasks.order_priority
    end

    @tasks = @tasks.page(params[:page]).per(10)

  end

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
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
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
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(
                                    :name,
                                    :content,
                                    :time,
                                    :priority,
                                    :status,
                                    label_ids: [] 
                                  )
    end


end
