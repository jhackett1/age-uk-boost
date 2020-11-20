class Organiser::UsersController < Organiser::BaseController
    before_action :set_user, only: [:show, :update]

    def index
        @users = User.all
        @users = @users.search(params[:query]) if params[:query].present?
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        @user.password = SecureRandom.urlsafe_base64
        if @user.save
            flash[:notice] = "User has been created"
            redirect_to organiser_users_path
        else
            render :new
        end
    end

    def show
    end

    def update
        @user.update(user_params)
        flash[:notice] = "User has been updated"
        render :show
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :role_id,
            :phone,
            :address,
            :postcode
        )
    end
end