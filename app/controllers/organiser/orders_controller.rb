class Organiser::OrdersController < Organiser::BaseController
    before_action :set_order, only: [:show, :update]

    def index
        @filterrific = initialize_filterrific(
            Order,
            params[:filterrific],
            persistence_id: false,
            available_filters: [
                :approved, 
                :urgent,
                :sorted_by
            ],
            select_options: {
                sorted_by: Order.options_for_sorted_by
            },
        ) or return
        @orders = @filterrific.find.page(params[:page])
    end

    def new
        @order = Order.new
    end

    def create
        @order = Order.create(order_params)
        if @order.save
            flash[:notice] = "Order has been created"
            redirect_to organiser_orders_path
        else
            render :new
        end
    end

    def show
    end

    def update

        # byebug

        @order.update(order_params)
        flash[:notice] = "Order has been updated"
        redirect_to request.referer
        # render :show
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(
            :urgent,
            :approved_at,
            :due,
            :client_id,
            :assignee_id,
            service_ids: []
        )
    end
end