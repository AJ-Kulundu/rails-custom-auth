class PasswordResetsController < ApplicationController
    skip_before_action :authenticated!
    before_action :set_user, only: %i[edit update]

    def new
    end

    def create
        if (user = User.find_by(password_reset_params))
            PasswordMailer.with(
                user: user,
                token: user.generate_token_for(:password_reset)
            ).password_reset.deliver_later

        else
            return redirect_to new_password_resets_path, alert: "Email not found."
        end

        redirect_to root_path, notice: "Check your email for a password reset link."
    end

    def edit
    end

    def update
        if @user.update(password_params)
            redirect_to new_sessions_path, notice: "Password updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def password_reset_params
        {email: params[:email]}
    end

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
    
    def set_user
        @user = User.find_by_token_for(:password_reset, params[:token])
        redirect_to new_password_resets_path, alert: "Invalid or expired token." unless @user.present?
    end
end