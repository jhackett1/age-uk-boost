class Organiser::ServicesController < Organiser::BaseController
    before_action :set_service, only: [:show, :update]

    def index
        @services = Service.all
    end

    def new
        @service = Service.new
    end

    def create
        @service = Service.create(service_params)
        if @service.save
            redirect_to organiser_services_path
        else
            render :show
        end
    end

    def show
    end

    def update
        @service.update(service_params)
        render :show
    end

    private

    def set_service
        @service = Service.find(params[:id])
    end

    def service_params
        params.require(:service).permit(
            :name
        )
    end
end