module Api
  module V1
    class CocktailsController < ApplicationController
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
        cocktail = Cocktail.new(cocktail_params)
        # proportions = []
        byebug
        params[:proportions].each do |prop|
          ingredient = Ingredient.find_or_create_by_name(name: prop.name)
          cocktail.proportions.build(ingredient_id: ingredient.id, cocktail_id: cocktail.id, amount: prop.amount)
        end

        if cocktail.save
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

      private
      def cocktail_params
        params.permit(:name, :description, :instructions, :source)
      end

      def proportions_params
        params.permit(:proportions)
      end
    end
  end
end

# Howard's pseudocode for a create method in cocktails controller
# here's our object from params
# params = {
#   cocktail_name: "Whiskey and water",
#   description: "the old classic",
#   instructions: "do this and that",
#    proportions: [
#     {
#       ingredient: "whiskey",
#       amount: "three fingers"
#     },
#     {
#       ingredient: "water",
#       amount: "four ounces"
#     }
#   ]
# }

# cocktail = Cocktail.create(cocktail_name, desc, instr)
# propportions = []
# params[proportions].each |prop| do
#   ingredient = Ingredient.find_or_create_by_name(prop.ingredient)
#   cocktail.proportions.build(ingredient_id: ingredient.id, cocktail_id: cocktail.id, amount: prop.amount)
# end
# if cocktail.save
