class AuthController < ApplicationController
    before_action :set_phone, only: [:create, :show]

    include TwilioClient

    def new
    end

    def create
        user = User.find_by(phone: @phone)
        if user
            token = (SecureRandom.random_number(9e5) + 1e5).to_i
            session = AuthSession.find_or_initialize_by({
                user: user
            })
            session.token = token
            session.timeout_at = 1.month.from_now
            session.expires_at = 10.minutes.from_now
            session.user_agent = request.user_agent
            session.save
            to = user.phone
            message = "#{token} is your verification code for Age UK"
            send_sms(to, message)
            # print "\n\n\n\n\n------\n\n\n\n\nYOUR CODE: #{token}\n\n\n\n\n------\n\n\n\n\n"
        end
    end

    def show
        user = User.find_by(phone: token_params[:phone])
        found_session = AuthSession.claimable.unexpired.find_by(
            user: user
        )
        if found_session
            if found_session.token == token_params[:token]
                found_session.claimed_at = Time.now
                session[:auth_session_id] = found_session.id
                found_session.save
                flash[:notice] = nil
                redirect_to root_path
            else
                flash[:notice] = "That code doesn't seem to be right. Please try again."
                render "create"
            end
        else
            flash[:notice] = "There was a problem signing you in. Please request a new code."
            redirect_to sign_in_path
        end
    end

    def destroy
        AuthSession.find(session[:auth_session_id]).destroy
        session[:auth_session_id] = nil
        flash[:notice] = "You've been signed out."
        redirect_to sign_in_path
    end

    private

    def set_phone
        @phone = PhonyRails.normalize_number(params[:phone])
    end

    def token_params
        params.permit(
            :phone,
            :token
        )
    end
end