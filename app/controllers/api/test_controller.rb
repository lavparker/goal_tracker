class Api::TestController < ApplicationController
  def create
     # Implement your action logic, including CSRF token verification if required.
    # For testing purposes, you can return a JSON response as you mentioned.
    render json: { message: 'CSRF token verified' }, status: :ok
  end
end
