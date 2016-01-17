class TasksController < ApplicationController

  def index
    # @tasks = Task.univer_search(params[:univer_search]).variant_search(params[:variant_search]).solved_search(params[:solved_search]).type_t_search(params[:type_t_search]).paginate(page: params[:page])
    @tasks = Task.univer_search(params[:univer_search]).variant_search(params[:variant_search]).solved_search(params[:solved_search]).type_t_search(params[:type_t_search])
    @tasks1 = @tasks.page(params[:page]).per(20)
    params[:page] = (params[:page] == nil ? 1 : params[:page])
    if @tasks1.total_pages < params[:page].to_i
      params[:page] = @tasks1.total_pages.to_s
    end
    @tasks = @tasks.page(params[:page]).per(20)
    @solved = {"+" => "1", "-" => "0"}
  end

  def api_tasks
    # @tasks = Task.univer_search(params[:univer_search]).variant_search(params[:variant_search]).solved_search(params[:solved_search]).type_t_search(params[:type_t_search])
    # @tasks1 = @tasks.page(params[:page]).per(20)
    # params[:page] = (params[:page] == nil ? 1 : params[:page])
    # if @tasks1.total_pages < params[:page].to_i
    #   params[:page] = @tasks1.total_pages.to_s
    # end
    # @tasks = @tasks.page(params[:page]).per(20)
    # @solved = {"+" => "1", "-" => "0"}
    # render :template => 'tasks/api_tasks', :layout => false
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Задача создана"
      redirect_to :back
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
