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
          render json: savedDrink
        else
          render json: { errors: co.errors.full_messages }, status: 422
        end

      end

      def show

      end

      def update
        savedDrink = SavedDrink.find(params[:id])
        ingredients = params[:proportions] # ing name and amount(quantity)
        savedDrink.update(savedDrink_params)

        if savedDrink.save
          ingredients.map do |ing|
            ingredient = Ingredient.find_or_create_by(name: ing['ingredient_name'])
            # amount: ing['amount'], saved_drink_id: savedDrink.id, ingredient_id: ingredient.id
            adj_prop = AdjustedProportion.find_or_create_by(saved_drink_id: savedDrink.id, ingredient_id: ingredient.id)
            adj_prop.update(amount: ing['amount'])
            # savedDrink.adjusted_proportions.build(adj_prop)
            # savedDrink.save
          end

          response = {
            id: savedDrink.id,
            name: savedDrink.name,
            description: savedDrink.description,
            instructions: savedDrink.instructions,
            source: savedDrink.source,
            proportions: savedDrink.adjusted_proportions.map do |prop|
              {
                id: prop.id,
                amount: prop.amount,
                ingredient: prop.ingredient.name
              }
            end
          }

          render json: response
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
