# frozen_string_literal: true

require './app/models/user'

def logged_in?
  !session[:user_id].nil?
end

# Define the condition
set(:auth) do |_condition|
  condition do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @admin = @user.admin?
    else
      flash[:notice] = 'please login!'
      redirect '/login'
    end
  end
end
