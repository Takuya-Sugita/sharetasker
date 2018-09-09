class RelationshipsController < ApplicationController
  def create
    follow = @current_user.active_relationships.build(follower_id: params[:id])
    follow.save
    redirect_to("/users/#{params[:id]}")
  end

  def destroy
    follow = @current_user.active_relationships.find_by(follower_id: params[:id])
    follow.destroy
    redirect_to("/users/#{params[:id]}")
  end
end
