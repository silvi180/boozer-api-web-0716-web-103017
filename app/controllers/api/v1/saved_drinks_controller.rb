module Api
  module V1
    class SavedDrinksController < ApplicationController

      def index
        render json: SavedDrink.all
      end

      def create
        ingredients = params[:proportions]
        savedDrink = SavedDrink.new(savedDrink_params)

        if savedDrink.save
          ingredredients.each do |ing|
            ingredient = Ingredient.find_or_create_by(name: ing['ingredient_name'])
            proportions = savedDrink.adjusted_proportions.build(ingredients)
            proportions.save
          end
          render json: savedDrink
        else
          render json: { errors: co.errors.full_messages }, status: 422
        end

      end

      def update
        savedDrink = SavedDrink.find(params[:id])
        ingredients = params[:proportions] # ing name and amount(quantity)
        savedDrink.update(savedDrink_params)

        if savedDrink.save
          byebug

          # savedDrink.adjusted_proportions.each do |ing|
          #   AdjustedProportions.find(id: )
          # end

            # proportions = savedDrink.proportions.build(ingredients)
            # proportions.save
          render json: savedDrink
        else
          render json: { errors: savedDrink.errors.full_messages }, status: 422
        end

      end

      def destroy
        savedDrink = SavedDrink.find(params[:id])
        savedDrink.destroy
        render json: { messsage: "Succesfully Deleted" }
      end

      private

      def savedDrink_params
        params.permit(:name, :description, :instructions, :source, :cocktail_id, :user_id)
      end
    end
  end
end
