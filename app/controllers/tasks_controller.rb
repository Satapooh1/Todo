class TasksController < ApplicationController
  def index
    @tasks = Task.where(status: "incomplete") # แสดงเฉพาะ tasks ที่ยังไม่เสร็จ
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.status = "incomplete"

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      @tasks = Task.where(status: "incomplete") # ปรับให้เรียกเฉพาะ incomplete tasks
      render :index
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(status: "complete")

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was marked as complete." }
      format.turbo_stream
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  private

  def task_params
    params.require(:task).permit(:title, :category_id)
  end
end
