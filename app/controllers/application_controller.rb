class ApplicationController < ActionController::API
    before_action :snake_case_params

  

    private

    def current_user
        return nil if session[:session_token] == nil 
        @current_user ||= User.find_by(session_token: session_token[:session_token])
    end

    def login!(user)
        
    end

    def snake_case_params
        params.deep_transform_keys!(&:underscore)
    end
end
