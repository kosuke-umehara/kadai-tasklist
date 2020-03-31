class TasklistsController < ApplicationController
  before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
  
  def index
      @tasklists = Tasklist.order(id: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @tasklist = Tasklist.new
  end

  def create
    @tasklist = Tasklist.new(tasklist_params)
    
    if @tasklist.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @tasklist.update(tasklist_params)
      flash[:success]= 'タスクは正常に更新されました'
      redirect_to @tasklist
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