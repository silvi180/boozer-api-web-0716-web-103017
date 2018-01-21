# module Api
#   module V1
#     class SavedDrinksController < ApplicationController
#       ActionController::Parameters.permit_all_parameters = true
#
#       def index
#         savedDrinks = SavedDrink.all.map do |cocktail|
#           {
#             id: cocktail.id,
#             name: cocktail.name,
#             description: cocktail.description,
#             instructions: cocktail.instructions,
#             source: cocktail.source,
#             proportions: cocktail.proportions.map do |prop|
#               {
#                 prop_id: prop.id,
#                 ingredient_id: prop.ingredient.id,
#                 ingredient_name: prop.ingredient.name,
#                 amount: prop.amount
#               }
#             end
#           }
#         end
#         render json: savedDrink
#
#       end
#
#       def create
#         drink = params[:savedDrink]
#         savedDrink = SavedDrink.new(name: params[:name], description: params[:description], instructions: params[:instructions], source: params[:source])
#
#           ingredients.each do |ing|
#             ingredient = Ingredient.find_or_create_by(name: ing['ingredient_name'])
#             prop = cocktail.proportions.build(ingredient_id: ingredient.id, cocktail_id: cocktail.id, amount: ing[:amount])
#             prop.save
#             # byebug
#           end
#           render json: cocktail
#         else
#           render json: { errors: co.errors.full_messages }, status: 422
#         end
#
#       end
#
#       def update
#         savedDrink = SavedDrink.find(params[:id])
#         savedDrink.update(params[:savedDrink])
#
#         if savedDrink.save
#           render json: savedDrink
#         else
#           render json: { errors: savedDrink.errors.full_messages }, status: 422
#         end
#
#       end
#
#       def destroy
#         savedDrink = SavedDrinktail.find(params[:id])
#         savedDrink.destroy
#         render json: { messsage: "Succesfully Deleted" }
#       end
#
#     end
#   end
# end
