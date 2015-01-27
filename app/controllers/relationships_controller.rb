class RelationshipsController < ApplicationController
  def create

    @user = User.find(params[:friend_id])
    current_user.send_request(@user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
