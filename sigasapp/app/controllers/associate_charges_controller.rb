class AssociateChargesController < ApplicationController
    protect_from_forgery :except => [:create]
    #before_filter :access_verify, except: [:show, :edit, :update]
  
   def create
    @associate = Associate.find(params[:associate_id]) 
    associate_charge = AssociateCharge.new
    associate_charge.description = params[:description]
    associate_charge.value = params[:value]
    associate_charge.due_date = params[:due_date]
    associate_charge.associate_id = params[:associate_id]
    
    respond_to do |format|
      if associate_charge.save
        format.html { redirect_to @associate, notice: 'Nova cobrança adicionada. ' }
        format.json { render :show, status: :created, location: @associate }
      else
        format.html { render :new }
        format.json { render json: @associate.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create_annuity
    @associate = Associate.find(params[:associate_id]) 
    annuity_form = params[:annuity_form].to_i
    if annuity_form <= 1 
      associate_charge = AssociateCharge.new
      associate_charge.description = "Anuidade Sócio"  
      associate_charge.value = @associate.category.value_in_cash
      associate_charge.due_date = Date.current.change(day: params[:dueday].to_i) 
      associate_charge.associate_id = params[:associate_id]
      associate_charge.save
    else
      for i in 1..annuity_form
        associate_charge = AssociateCharge.new
        associate_charge.description = "Anuidade Sócio #{i}/#{annuity_form}"  
        associate_charge.value = @associate.category.value_in_installments / annuity_form
        month = (Date.current.month + i) > 12 ? (Date.current.month + i) - 12 : (Date.current.month + i) 
        associate_charge.due_date = Date.current.change(day: params[:dueday].to_i, month: month) 
        associate_charge.associate_id = params[:associate_id]
        associate_charge.save
      end
    end
     
    respond_to do |format|
      format.html { redirect_to @associate, notice: 'Cobrança de anuidade adicionada. ' }
      format.json { render :show, status: :created, location: @associate }
    end
  end
  
  def update
    charge = AssociateCharge.find(params[:id])
    respond_to do |format|
      if charge.update(charge_params)
        format.html { redirect_to charge.associate, notice: 'Status da cobrança alterado.' }
      else
        format.html { render :edit }
        format.json { render json: @associate.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def get_charges
    associate_id = params[:associate_id]
    year = Date.new(params[:year].to_i)
    chargelist = []
    charges = AssociateCharge.where(associate_id: associate_id).where(:due_date => year..year.end_of_year)
    charges.each do |charge|
      chargelist << [charge.description, charge.print_value, charge.due_date.strftime('%d/%m/%Y'), charge.situation, charge_path(charge.id), remove_charge_path(charge.associate_id, charge.id)]     
    end
    respond_to do |format|
      format.json { render json: chargelist }
    end
  end
  
  def show
    @charge = AssociateCharge.find(params[:id])
  end
  
  def remove_charge
    associate = Associate.find(params[:associate_id])
    charge = AssociateCharge.find(params[:id])
    respond_to do |format|
      if charge.situation == "Paga"
        format.html { redirect_to associate, notice: 'Não é permitido remover uma cobrança já paga.'}
      elsif charge.destroy!
        format.html { redirect_to associate, notice: 'Dependente removido com sucesso.'}
        format.json { head :no_content }
      end
    end
  end
  
  
  private
    def charge_params
      params.fetch(:associate_charge, {}).permit(:description, :associate_id, :value, :due_date, :pay_date, :additions, :discounts, :payment_form, :obs)
    end
  
  protected
    def access_verify
      #unless ["admin"].include? User.find(session[:current_user]).permission
      redirect_to dashboards_path
      #end
    end
end
