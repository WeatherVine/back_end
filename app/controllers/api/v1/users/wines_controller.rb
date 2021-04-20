class Api::V1::Users::WinesController < ApplicationController
  
  def create
    user_wine = UserWine.create(user_wine_params)
    render json: UserWineSerializer.new(user_wine)
  end

  private

  def user_wine_params
    params.require(:user_wine).permit(:wine_id, :user_id, :comment)
  end
end