module Api
  module V1
    class ProportionsController < ApplicationController

      def create
        proportion = Proportion.new(:ingredient_id, :cocktail_id, :amount)

        if proportion.save
          render json: proportion
        else
          render json: {errors: proportion.errors.full_messages}, status: 422
        end
      end


      def update
        proportion = Proportion.find(params[:id])
        proportion.update(:ingredient_id, :cocktail_id, :amount)

        if proportion.save
          render json: proportion
        else
          render json: {errors: proportion.errors.full_messages}, status: 422
        end
      end

      def destroy
        proportion = Proportion.find(params[:id])
        proportion.destroy
        render json: { messsage: "Succesfully Deleted" }
      end

    end
  end
end
