class Organiser::ReceiptsController < Organiser::BaseController
    before_action :set_receipt, only: [:show, :update]

    def index
        @receipts = Receipt.all
    end

    def new
        @receipt = Receipt.new
    end

    def create
        @receipt = Receipt.create(receipt_params)
        if @receipt.save
            flash[:notice] = "Receipt has been created"
            redirect_to organiser_receipts_path
        else
            render :show
        end
    end

    def show
    end

    def update
        @receipt.update(receipt_params)
        flash[:notice] = "Receipt has been updated"
        render :show
    end

    private

    def set_receipt
        @receipt = Receipt.find(params[:id])
    end

    def receipt_params
        params.require(:receipt).permit(
            :total,
            :user_id,
            :image,
            order_ids: []
        )
    end
end