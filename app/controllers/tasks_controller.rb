class TasksController < ApplicationController

  def index
    @tasks_vutbr = Task.where(univer: 1).paginate(page: params[:page])
    @tasks_masarikov = Task.where(univer: 2).paginate(page: params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Задача создана"
      render 'new'
    else
      render 'new'
    end
  end


  def edit
    @task = Task.find(params[:id])
  end


  def update
    @task = Task.find_by_id(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Задача обновлена"
      redirect_to @task
    else
      render 'edit'
    end
  end

  def show
    @task = Task.find(params[:id])
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end

  def delete_image
    @task = Task.find(params[:id])
    @task.photo = nil
    @task.save!
    redirect_to :back
  end

  private

  def task_params
    params.require(:task).permit(:russian_text, :czech_text, :type_t, :solved,
                                 :variant, :number, :answer, :photo, :univer)
  end

end
