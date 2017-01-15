class AssociatesController < ApplicationController
  before_action :set_associate, only: [:show, :edit, :update, :destroy]
  #before_filter :access_verify, except: [:show, :edit, :update]

  # GET /associates
  # GET /associates.json
  def index
    @associates = Associate.all
  end

  # GET /associates/1
  # GET /associates/1.json
  def show
  end

  # GET /associates/new
  def new
    @associate = Associate.new
  end

  # GET /associates/1/edit
  def edit
  end

  # POST /associates
  # POST /associates.json
  def create
    @associate = Associate.new(associate_params)

    respond_to do |format|
      if @associate.save
        format.html { redirect_to @associate, notice: 'Novo sócio cadastrado com sucesso. ' }
        format.json { render :show, status: :created, location: @associate }
      else
        format.html { render :new }
        format.json { render json: @associate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /associates/1
  # PATCH/PUT /associates/1.json
  def update
    respond_to do |format|
      if @associate.update(associate_params)
        format.html { redirect_to @associate, notice: 'Dados do sócio atualizados com sucesso.' }
        format.json { render :show, status: :ok, location: @associate }
      else
        format.html { render :edit }
        format.json { render json: @associate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /associates/1
  # DELETE /associates/1.json
  def destroy
    @associate.destroy
    respond_to do |format|
      format.html { redirect_to associates_url, notice: 'Associate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def status_change
    associate = Associate.find(params[:associate_id])
    associate.active = !associate.active
    respond_to do |format|
      if associate.save!
        format.html { redirect_to associate}
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_associate
      @associate = Associate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def associate_params
      params.fetch(:associate, {}).permit(:name, :gender, :birthdate, :photo, :cpf, :rg, :address, :district, :city, :cep, :phone, :optional_phone, :email, :category, :adminission_date, :obs)
    end
    
   protected
    def access_verify
      #unless ["admin"].include? User.find(session[:current_user]).permission
      redirect_to dashboards_path
      #end
    end
end
