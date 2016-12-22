class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  #before_filter :access_verify, except: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new(:active => true)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    pwd = User.random_password
    @user.password = pwd

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user,pwd).deliver
        
        format.html { redirect_to users_path, notice: 'Usuário cadastrado com sucesso.' }
        format.json { render action: 'show', status: :created, location: users_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user == session[:current_user]
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to home_path, notice: 'Usuário atualizado com sucesso!' }
          format.json { head :no_content }
        else
          format.html { redirect_to preferences_path, notice: 'Houve um problema, repita o processo.'  }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_path, notice: 'Usuário atualizado com sucesso!' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    redirect_to users_path if @user == session[:current_user]
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end
  
  def status_change
    @user = User.find(params[:user_id])
    @user.active = @user.id == 1 ? true : !@user.active
    respond_to do |format|
      if @user.save!
        format.html { redirect_to users_path}
        format.json { head :no_content }
      end
    end
  end
  
  def reset_pwd
    @user = User.find(params[:user_id])
    pwd = User.random_password
    @user.password = pwd
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.reset_pwd_email(@user,pwd).deliver
        format.html { redirect_to users_path, notice: 'Uma nova senha foi enviada para o endereço de e-mail.' }
        format.json { render action: 'show', status: :created, location: users_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :email, :phone, :role, :photo)
    end
  
  protected
    def access_verify
      #unless ["admin"].include? User.find(session[:current_user]).permission
      redirect_to dashboards_path
      #end
    end
end
