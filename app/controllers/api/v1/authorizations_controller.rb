require 'jwt'
module Api
  module V1
    class AuthorizationsController < ApplicationController

      def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          byebug
          render json: {id: user.id, username: user.username, token: issue_token(user)}
        else
          render({json: {error: 'User is not valid'}, status: 401})
        end
      end

      def show

        if current_user
          render json: {id: current_user.id, username: current_user.username, token: issue_token(the_current_user)}
        else
          render({json: {error: 'Token is not valid'}, status: 401})
        end
      end

    end
  end
end