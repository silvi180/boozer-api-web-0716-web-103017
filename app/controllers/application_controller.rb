class ApplicationController < ActionController::API
  ActionController::Parameters.permit_all_parameters = true


  def issue_token(user)
    # JWT.encode(payload, secret_key, algorithm)
    token = JWT.encode({id: user.id}, 'secret', 'HS256')
  end

  def token
    begin
      JWT.decode(request.headers['Authorization'], 'secret', true, { :algorithm => 'HS256' })
    rescue JWT::DecodeError
      [{}]
    end
  end

  def user_id
    token.first["id"]
  end

  def current_user
    # if @user
    #   @user
    # else
    #   @user = User.find_by(id: user_id)
    # end
    # below is the same logic as above
    @user ||= User.find_by(id: user_id )
  end


end
