class Api::V1::Users::WinesController < ApplicationController
  def create
    # wine = Wine.find_or_create_by(api_id: params[:wine_id]) do |wine|
    #   wine.name = params[:name]
    # end
    user_wine = UserWine.create(user_wine_params)
    # user_wine = UserWine.create(user_id: params[:user_id], wine_id: wine.id, comment: params[:comment])
    render json: UserWineSerializer.new(user_wine)
  end


  private

  def user_wine_params
    params.require(:user_wine).permit(:wine_id, :user_id, :comment)
  end
end
