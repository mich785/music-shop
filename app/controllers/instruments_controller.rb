class InstrumentsController < ApplicationController
#unwrap the nested hash we are passing to the create method
wrap_parameters format: []

rescue_from ActiveRecord::RecordNotFound ,with: :render_not_found_response

    def index
    instruments = Instrument.all
    render json: instruments , status: :ok
     end

     def show 
     instrument = Instrument.find_by(id:params[:id])
     if instrument
        render json: instrument , status: :ok
     else
        render_not_found_response
     end

     end

     def create
     instrument = Instrument.create(instrument_params)
     render json: instrument , status: :ok
     end

     def update
        instrument = Instrument.find_by(id:params[:id])
        if instrument
        instrument.update(instrument_params)
            render json: instrument , status: :ok
        else
            render_not_found_response
        end
    end

        def destroy 
            instrument = find_instrument
            instrument.destroy
            head :no_content
        rescue ActiveRecord::RecordNotFound
                render_not_found_response    
        end

     

     private 
     def instrument_params
        params.permit(:name,:brand,:family,:price,:shop_id)
     end
    
     def render_not_found_response
        render json: {error:"Oops!Instrument not found"},status: :not_found
     end

     def find_instrument
        Instrument.find(params[:id])
     end
end
