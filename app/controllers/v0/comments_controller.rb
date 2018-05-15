class V0::CommentsController < ApplicationController
  def show
     @comment = Comment.find(params[:id])
  end
end
