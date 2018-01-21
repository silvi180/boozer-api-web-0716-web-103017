
module Api
  module V1
    class CocktailsController < ApplicationController
      # ActionController::Parameters.permit_all_parameters = true

      def index
        cocktails = Cocktail.all.map do |cocktail|
          {
            id: cocktail.id,
            name: cocktail.name,
            description: cocktail.description,
            instructions: cocktail.instructions,
            source: cocktail.source,
            proportions: cocktail.proportions.map do |prop|
              {
                prop_id: prop.id,
                ingredient_id: prop.ingredient.id,
                ingredient_name: prop.ingredient.name,
                amount: prop.amount
              }
            end
          }
        end
        render json: cocktails


      end

      def show
        cocktail = Cocktail.find(params[:id])

        cocktail_json = {
          id: cocktail.id,
          name: cocktail.name,
          description: cocktail.description,
          instructions: cocktail.instructions,
          source: cocktail.source,
          proportions: cocktail.proportions.map do |prop|
            {
              prop_id: prop.id,
              ingredient_id: prop.ingredient.id,
              ingredient_name: prop.ingredient.name,
              amount: prop.amount
            }
          end
        }
        render json: cocktail_json
      end

      def create
        ingredients = params[:proportions]
        cocktail = Cocktail.new(name: params[:name], description: params[:description], instructions: params[:instructions], source: params[:source])

        if cocktail.save
          ingredients.each do |ing|
            ingredient = Ingredient.find_or_create_by(name: ing['ingredient_name'])
            prop = cocktail.proportions.build(ingredient_id: ingredient.id, cocktail_id: cocktail.id, amount: ing[:amount])
            prop.save
            # byebug
          end
          render json: cocktail
        else
          render json: { errors: co.errors.full_messages }, status: 422
        end

      end

      def update
        cocktail = Cocktail.find(params[:id])
        cocktail.update(cocktail_params)

        if cocktail.save
          render json: cocktail
        else
          render json: { errors: cocktail.errors.full_messages }, status: 422
        end

      end

      def destroy
        cocktail = Cocktail.find(params[:id])
        cocktail.destroy
        render json: { messsage: "Succesfully Deleted" }
      end

    end
  end
end
