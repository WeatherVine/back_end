class Api::V1::Users::DashboardController < ApplicationController
  def show
    # Get openstruct of data we want to send: api_id, name, comment
    render json: UserDashboardSerializer.new(fetch_dashboard_data(params[:id]))
  end

  def destroy
    user_wine = UserWine.find_by!(
      user_id: params[:user_id],
      wine_id: params[:wine_id]).destroy

    render json: user_wine
  end

  private

  def fetch_dashboard_data(user_id)
    UserWine.for_user_dashboard(user_id)
  end
end
