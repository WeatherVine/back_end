class Api::V1::Users::DashboardController < ApplicationController
  def show
    # Get openstruct of data we want to send: api_id, name, comment
    render json: UserDashboardSerializer.new(fetch_dashboard_data(params[:id]))
  end

  def destroy
    wine = Wine.find_by(api_id: params[:wine_id])

    user_wine = UserWine.find_by!(
      user_id: params[:user_id],
      wine_id: wine.id
    ).destroy

    render json: user_wine
  end

  private

  def fetch_dashboard_data(user_id)
    UserWine.for_user_dashboard(user_id)
  end
end
