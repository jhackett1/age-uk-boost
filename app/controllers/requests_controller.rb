class RequestsController < ApplicationController
    def index
    end

    def new
        @user = User.new
        @user.orders.new
    end
end
