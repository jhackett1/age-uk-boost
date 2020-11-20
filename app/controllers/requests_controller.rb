class RequestsController < ApplicationController
    def index
    end

    def new
        @user = User.new
        @user.orders.build
    end

    def create
        @user = User.create(user_params)
        @user.role = Role.find_by(name: "client")
        @user.password = SecureRandom.urlsafe_base64
        if @user.save
            flash[:notice] = "Request sent"

            session = Stripe::Checkout::Session.create({
                payment_method_types: ['card'],
                line_items: @user.orders.last.services.map{ |s| {
                    price_data: {
                        currency: "gbp",
                        product_data: {
                            name: s.name
                        },
                        unit_amount: s.stripe_price
                    },
                    quantity: 1
                }},
                mode: "payment",
                success_url: 'https://example.com/success',
                cancel_url: 'https://example.com/cancel',
            })

            byebug

            redirect_to root_path
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :first_name,
            :last_name,
            :email,
            :role_id,
            :phone,
            :address,
            :postcode,
            orders_attributes: [
                :id,
                :urgent,
                service_ids: []
            ]
        )
    end
end
