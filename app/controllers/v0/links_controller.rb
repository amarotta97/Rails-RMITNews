class V0::LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
  end
  
  def create
    @link = Link.new(create_params)
    @link.user = current_user
    
    if @link.save
      render :show
    else
      render json: @link.errors.full_messages.join('.'), status: 400
    end
  end
  
  private
  
  def create_params
    params.require(:link).permit(:title, :url)
  end
end
