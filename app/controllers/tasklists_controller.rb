class TasklistsController < ApplicationController
  def index
      @tasklists = Tasklist.all
  end

  def show
      @tasklist = Tasklist.find(params[:id])
  end

  def new
       @tasklist = Tasklist.new
  end

  def create
    @tasklist = Tasklist.new(tasklist_params)
    
    if @tasklist.save
      flash[:danger] = 'タスクが正常に追加されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
  end

  def edit
    @tasklist = Tasklist.find(params[:id])
  end

  def update
    @tasklist = Tasklist.find(params[:id])
    
    if @tasklist.update(tasklist_params)
      flash[tasklist]= 'タスクは正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:dangeer]= 'タスクは正常に更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasklist = Tasklist.find(params[:id])
    @tasklist.destroy
    
    flash[:success] = 'タスクは正常に更新されました'
    redirect_to tasklists_url
  end
end

private

def tasklist_params
  params.require(:tasklist).permit(:content)
  