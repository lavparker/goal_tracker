class ApplicationController < ActionController::API
    before_action :snake_case_params
    before_action :test, only: [:test]

    private 

    def current_user

        return nil if session[:session_token].nil?

        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        @current_user = user 
        session[:session_token] = user.reset_session_token!
        @current_user = user 

    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil 
    end

   
  def require_logged_in
    unless current_user
    render json: { message: 'Unauthorized' }, status: :unauthorized 
  end
  end

    
    def snake_case_params
        params.deep_transform_keys!(&:underscore)
    end
end
