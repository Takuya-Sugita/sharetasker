class LikesController < ApplicationController
  before_action :authenticate_user!


  # relationships_controllerのcreateとdestroyと同じ記述方法

  def create
    @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    @like.save
    flash[:notice] = "TASKをチャレンジ！！"
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    flash[:notice] = "チャレンジをキャンセルしました"
    redirect_to("/posts/#{params[:post_id]}")
  end


end
