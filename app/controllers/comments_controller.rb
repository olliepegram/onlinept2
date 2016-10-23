class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    listing = Listing.find_by(id: params[:id])
    comment = listing.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment has been created."
      redirect_to listing
    else
      flash[:alert] = "Comment has not been created."
    end
  end

  private
    def comment_params
      params.permit(:comment)
    end
end
