class Volunteer::ReceiptsController < Volunteer::BaseController
    def index
        @receipts = current_user.receipts
    end

    def new
        @receipt = current_user.receipts.new
    end

    def create
        @receipt = current_user.receipts.create(receipt_params)
        if @receipt.save
            flash[:notice] = "Receipt has been created"
            redirect_to volunteer_receipts_path
        else
            render :show
        end
    end

    private

    def receipt_params
        params.require(:receipt).permit(
            :total,
            :image,
            order_ids: []
        )
    end
end