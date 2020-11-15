class Organiser::UsersController < Organiser::BaseController
    def index
        @users = User.all
    end
end