class SessionsController < ApplicationController
    skip_before_action :authenticated!
    before_action :redirect_if_authenticated, only: [:new]
    def new
    end

    def create
        if (user = User.authenticate_by(user_params))
            sign_in user
            redirect_to root_path, notice: "Signed in!"
        else
            flash.now[:alert] = "Invalid email or password"
            render "new", status: :unprocessable_entity
        end
    end

    def destroy
        sign_out current_user
        redirect_to new_sessions_path, alert: "Signed out!"
    end

    private
    def user_params
        {email: params[:email], password: params[:password]}
    end
end
