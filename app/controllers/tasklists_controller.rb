class TasklistsController < ApplicationController
  before_action :require_user_logged_in,only:[:show,:edit,:update,:destroy]
  before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasklists = current_user.tasklists.order(id: :desc).page(params[:page]).per(3)
    end
  end

  def show
  end

  def new
    @tasklist = current_user.tasklists.build
  end

  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    
    if @tasklist.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order(id: :desc).page(params[:page]).per(3)
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @tasklist.update(tasklist_params)
      flash[:success]= 'タスクは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:dangeer]= 'タスクは正常に更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasklist.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasklists_url
  end

private

  def set_tasklist
    @tasklist = Tasklist.find(params[:id])
  end

  def tasklist_params
    params.require(:tasklist).permit(:content, :title)
  end
end