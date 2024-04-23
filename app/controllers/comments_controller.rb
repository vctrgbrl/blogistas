# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comments_params)
    @comment.user_id = current_user.id if current_user != nil
    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_url(post), notice: "Comentário adicionado" }
      else
        format.html {render post_url(post) }
      end
    end
  end

  def new
    @comment = Post.find(comments_params[:post_id]).comments.build
  end

  private
  def comments_params
    params.require(:comment).permit(:post_id, :body)
  end
end