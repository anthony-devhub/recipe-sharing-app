class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @recipe }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
