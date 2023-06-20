class ShopsController < ApplicationController
    #unwrap the nested hash we are passing to the create method
    wrap_parameters format: []
    #rescue_from ActiveRecord::RecordNotFound ,with: :render_not_found_response

    def index
        shops = Shop.all 
        render json: shops , status: :ok
    end

    def show 
        shop = Shop.find_by(id:params[:id])
         if shop 
            render json: shop ,only: [:name, :location] ,status: :ok
         else
            render json:{error: "Oops!Shop not found"} ,status: :not_found
         end   
    end

    def create 
        shop = Shop.create(shop_params)
        render json: shop , status: :created 
    end

    def update
        shop = Shop.find_by(id:params[:id])
         if shop 
            shop.update(shop_params)
            render json: shop , status: :accepted
         else
            render json:{error: "Oops!Shop not found"} ,status: :not_found
         end   
    end

    def destroy
        shop = Shop.find_by(id:params[:id])
        if shop 
            shop.destroy
            head :no_content
        else
            render json:{error: "Oops!Shop not found"} ,status: :not_found   
        end
        
    end    

    def destroy
        shop = find_shop_2
        shop.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render_not_found_response
    end   

   private

   def shop_params
    params.permit(:name,:location)
   end

#    def render_not_found_response
#     render json:{error: "Oops!Shop not found"} ,status: :not_found 
#    end

# def find_shop
#     Shop.find_by(id:params[:id]) 
# end

def find_shop_2
    Shop.find(params[:id]) 
end
end
