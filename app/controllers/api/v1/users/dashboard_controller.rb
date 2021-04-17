class Api::V1::Users::DashboardController < ApplicationController
  def show
    # Get openstruct of data we want to send: api_id, name, comment
    render json: UserDashboardSerializer.new(fetch_dashboard_data(params[:id]))
  end

  private

  def fetch_dashboard_data(user_id)
    UserWine.for_user_dashboard(user_id)
  end
end
