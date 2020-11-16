class Volunteer::TasksController < Volunteer::BaseController
    before_action :set_order, only: [:show, :update]

    def index
        @orders = Order.all
    end

    def show
    end

    def update
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end
end