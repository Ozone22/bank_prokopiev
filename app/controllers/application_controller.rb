class ApplicationController < ActionController::API
  include Authentication

  respond_to :json

  protected

  def correct_user
    id = params[:user_id] || params[:id]
    user = User.find_by(id: id)
    head :forbidden if user && current_user != user
  end

  def pagination_info(collection)
    {
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  def respond_with_token(token)
    render json: { authentication_token: token }, status: :created
  end
end
