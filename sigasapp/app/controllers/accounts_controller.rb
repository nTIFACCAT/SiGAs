class AccountsController < ApplicationController
  #skip_before_action :authenticate, only: [:logout]
  skip_before_action :verify_authenticity_token 
  #skip_before_filter :access_verify_session, only: [:login]

  def login
    if request.post?
      @email = params[:email]
      if User.authenticate(@email, params[:password])
        session[:current_user] = User.authenticate(@email, params[:password]).id
        successful_authentication
        redirect_to home_path
      else
        @login_error_flag = true
        logger.warn "Failed login for '#{params[:username_or_email]}' from #{request.remote_ip} at #{Time.now.utc}"
        render action: 'login', :layout => false 
      end
    else 
      render :layout => false  
    end
  end

  def logout
    render :layout => false
    reset_session
    session[:current_user] = nil
  end

  def edit
  end

  def update
    #TODO fazer aqui os esquemas
  end
  
  def preferences
    @user = User.find(session[:current_user])
  end

  private
    def successful_authentication
      logger.info "Authentication successful for '#{params[:username_or_email]}' from #{request.remote_ip} at #{Time.now.utc}"
      User.find(session[:current_user]).update_columns({
        last_sign_in_at: Time.zone.now.utc,
        last_sign_in_ip: request.remote_ip
      })
    end
end
