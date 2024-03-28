class SessionsController < ApplicationController
  # POST /sessions
  def create
    # Find the user by username
    @user = User.find_by(username: params[:user][:username])

    # If the user exists and the decrypted password is correct
    if @user && BCrypt::Password.new(@user.password) == params[:user][:password]
      # Create a new session for the user
      session = @user.sessions.create

      # Set cookies key todo_list_session_token to the session token
      # .permanent means the cookie will last for 20 years
      # .signed means the cookie will be encrypted
      # httponly: true means the cookie can only be accessed by the server
      cookies.permanent.signed[:todolist_session_token] = {
        value: session.token,
        httponly: true
      }

      # Return a success response
      render json: {
        success: true
      }
    else
      # Return a failure response
      render json: {
        success: false
      }
    end
  end

  # GET /authenticated
  def authenticated
    # Find the session by the session token
    token = cookies.permanent.signed[:todolist_session_token]
    session = Session.find_by(token: token)

    # if the session exists, return the username
    if session
      user = session.user

      render json: {
        authenticated: true,
        username: user.username
      }
    # if the session does not exist, return a failure response
    else
      render json: {
        authenticated: false
      }
    end
  end

  # DELETE /sessions
  def destroy
    # Find the session by the session token
    token = cookies.permanent.signed[:todolist_session_token]
    session = Session.find_by(token: token)

    # if the session exists and is destroyed, return a success response
    if session and session.destroy
      render json: {
        success: true
      }
    end

  end
end
