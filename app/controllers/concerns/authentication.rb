module Authentication 
    extend ActiveSupport::Concern

    included do
        helper_method :user_signed_in?, :current_user
    end

    def sign_in(user)
        Current.user = user
        reset_session 
        cookies.encrypted[:user_id] = user.id
    end

    def sign_out(user)
        Current.user = nil
        reset_session
        cookies.delete(:user_id)
    end

    def authenticated!
        if current_user.blank?
            redirect_to new_sessions_path, alert: "You need to sign in to continue"
        end
    end

    def redirect_if_authenticated
        redirect_to root_path if user_signed_in?
    end

    private

    def user_signed_in?
        current_user.present?
    end

    def current_user
        Current.user ||= authenticate_user_from_session
    end

    def authenticate_user_from_session
        User.find_by(id: cookies.encrypted[:user_id])
    end

end