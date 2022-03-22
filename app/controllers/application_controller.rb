class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :record_not_valid

  before_action :authorize

  private

  def authorize
    render json: {errors: ["Not Authorized"]}, status: :unauthorized unless session.include? :user_id
  end

  def record_not_valid(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end   

end
