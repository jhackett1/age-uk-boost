class AuthController < ApplicationController
    before_action :set_phone, only: [:create, :show]

    include TwilioClient

    def new
    end

    def create
        user = User.find_by(phone: @phone)
        if user
            token = (SecureRandom.random_number(9e5) + 1e5).to_i
            session = AuthSession.create({
                user: user,
                token: token,
                timeout_at: 1.month.from_now,
                expires_at: 10.minutes.from_now,
                user_agent: request.user_agent
            })

            to = user.phone
            message = "#{token} is your verification code for Age UK"
            send_sms(to, message)
        end
    end

    def show
        user = User.find_by(phone: token_params[:phone])
        possible_sessions = AuthSession.claimable.unexpired.where(user: user)
        if possible_sessions
            matching_session = possible_sessions.find{ |s| s.token == token_params[:token] }
            if matching_session
                matching_session.claimed_at = Time.now
                session[:auth_session_id] = matching_session.id
                matching_session.save
                flash[:notice] = nil
                redirect_to root_path
            else
                flash[:notice] = "That code doesn't seem to be right. Please try again."
                render "create"
            end
        else
            flash[:notice] = "That code has expired. Please request a new one."
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