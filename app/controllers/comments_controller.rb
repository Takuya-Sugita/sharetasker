class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :confirm_correct_user, {only: [:destroy]}


  def create
    @comment = Comment.new(
      comment: params[:comment],
      user_id: current_user.id,
      post_id: params[:id]
    )

    if params[:cimage]
      @comment.comment_image = "#{@comment.comment_image}.jpg"
      image = params[:cimage]
      File.binwrite("/home/vagrant/rails_lessons/sharetasker/public/comment_images/#{@comment.comment_image}", image.read)
    end

    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to("/posts/#{params[:id]}")
    else
      redirect_to("/posts/#{params[:id]}")
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to("/posts/index")
  end

  def confirm_correct_user
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("posts/index")
    end
  end




end
