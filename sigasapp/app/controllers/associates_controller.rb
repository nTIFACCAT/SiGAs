class AssociatesController < ApplicationController
  before_action :set_associate, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:create_direction_role, :create_associate_bond]
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
    if associate_params[:category] != 2
      bond = AssociateBond.where(dependent_id: @associate.id)
      if bond.any?
        bond.first.destroy
      end
    end
    
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
  
  def create_direction_role
    role = DirectionRole.new
    associate = Associate.find(params[:associate_id])
    role.associate = associate   
    role.role = params[:role]
    role.biennium = params[:biennium]
    respond_to do |format|
      if role.save!
        format.html { redirect_to associate, notice: 'Cargo adicionado com sucesso.'}
        format.json { head :no_content }
      end
    end
  end
  
  def get_direction_role
    associate = Associate.find(params[:associate_id])
    roles = DirectionRole.where(:associate => associate)
    respond_to do |format|
      format.json { render json: roles }
    end
  end
  
  def remove_direction_role
    associate = Associate.find(params[:associate_id])
    role = DirectionRole.find(params[:id])
    respond_to do |format|
      if role.destroy!
        format.html { redirect_to associate, notice: 'Cargo removido com sucesso.'}
        format.json { head :no_content }
      end
    end
  end
  
  def get_dependents
    associates = Associate.where(category_id: 2).select(:id, :name, :registration)
    associateslist = []
    associates.each do |associate|
      associateslist << associate unless AssociateBond.where(dependent_id: associate.id).any?
    end
    respond_to do |format|
      format.json { render json: associateslist }
    end
  end
  
  def get_dependents_data
    associate_id = params[:associate_id]
    associateslist = []
    dependents = AssociateBond.where(associate_id: associate_id)
    dependents.each do |dependent|
      associate = Associate.find(dependent.dependent_id)
      associateslist << [associate.name.split(' ')[0], dependent.bond, associate.photo.url, associate_path(dependent.dependent_id), remove_dependent_path(associate.id, dependent.id)]     
    end
    respond_to do |format|
      format.json { render json: associateslist }
    end
  end
  
  def remove_dependent
    associate = Associate.find(params[:associate_id])
    dependent = AssociateBond.find(params[:id])
    respond_to do |format|
      if dependent.destroy!
        format.html { redirect_to associate, notice: 'Dependente removido com sucesso.'}
        format.json { head :no_content }
      end
    end
  end
  
  def create_associate_bond
    associate = Associate.find(params[:associate_id])
    bond = AssociateBond.new
    bond.bond = params[:bond]
    bond.associate_id = associate.id   
    bond.dependent_id = Associate.where(registration: params[:name].split(' - ')[0]).first.id
    respond_to do |format|
      if bond.save!
        format.html { redirect_to associate, notice: 'Dependente adicionado com sucesso.'}
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
