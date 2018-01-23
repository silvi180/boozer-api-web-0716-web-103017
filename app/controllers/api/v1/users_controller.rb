module Api
  module V1
    class UsersController < ApplicationController
      def index
        render json: User.all
      end

      def show
        user = User.find(params[:id])

        user_json = {
          id: user.id,
          firstname: user.firstname,
          lastname: user.lastname,
          email: user.email,
          bio: user.bio,
          saved_drinks: user.saved_drinks.map do |drink|
            {
              user_drink_id: drink.id,
              name: drink.name,
              description: drink.description,
              instructions: drink.instructions,
              source: drink.source,
              cocktail_id: drink.cocktail_id,
              proportions: drink.proportions.map do |prop|
                {
                  ingredient_name: prop.ingredient.name,
                  amount: prop.amount
                }
              end,
              adjusted_proportions: drink.adjusted_proportions.map do |prop|
                {
                  ingredient_name: prop.ingredient.name,
                  amount: prop.amount
                }
              end
            }
          end
        }
        render json: user_json
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: { errors: user.errors.full_messages }, status: 422
        end

      end

      def update
        user = User.find(params[:id])

        if user && user.update(user_params)
          render json: user
        else
          render json: { errors: user.errors.full_messages }, status: 422
        end

      end

      def destroy
        user = User.find(params[:id])

        if user && user.destroy
          render json: { messsage: "Succesfully Deleted" }
        else
          render json: { messsage: "Unsuccesfully Deleted" }
        end
      end

      private

      def user_params
        params.permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :age, :bio)
      end

    end
  end
end
