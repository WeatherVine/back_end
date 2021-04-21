class Api::V1::WinesController < ApplicationController
  def show
    wine_show_data = WineFacade.fetch_all_the_things(params[:id])
    render json: WineWeatherSerializer.new(wine_show_data)
  end
end
