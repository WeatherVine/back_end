class Api::V1::Users::WinesController < ApplicationController
  before_action :create_wine, only: [:create]

  def create
    user_wine = UserWine.create(user_id: params[:user_id],
                                wine_id: @wine.id,
                                comment: params[:comment])
    render json: UserWineSerializer.new(user_wine)
  end

  private

  def create_wine
    @wine = Wine.find_or_create_by(api_id: params[:wine_id]) do |wine|
      wine.name = params[:name]
    end
  end
end
