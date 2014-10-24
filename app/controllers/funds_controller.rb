class FundsController < ApplicationController
  before_action :authenticate_admin!, except: [:index]
  before_action :set_fund, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html {
        if authenticate_admin! && search_params.present?
          @funds = Fund.search(search_params).order('created_at DESC').page(params[:page])
        else
          @funds = Fund.all.order('created_at DESC').page(params[:page])
        end
      }
      format.json { render json: Fund.all }
      format.csv { send_data Fund.to_csv }
    end
  end

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(fund_params)

    if @fund.save
      redirect_to funds_path, notice: "El programa fue creado satisfactoriamente."
    else
      render :new, alert: @fund.errors
    end
  end

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    if @fund.update_attributes(fund_params)
      redirect_to funds_path, notice: "El programa fue actualizado satisfactoriamente."
    else
      render :edit
    end
  end

  def destroy
    @fund.destroy
    redirect_to funds_path, alert: "El programa seleccionado fue borrado."
  end

  private

  def set_fund
    @fund = Fund.find(params[:id])
  end

  def fund_params
    params.require(:fund).permit(
      :friendly_id,
      :name,
      :institution,
      :description,
      :priority,
      :geographic_operator,
      :contact,
      :address,
      :phone,
      :other_phone,
      :email,
      :website,
      home_delegation: [],
      business_delegation: [],
      characteristics: [],
      deliver_method: [],
      clasification: [],
      special_filters: [],
      custom_delegation: []
    )
  end

  def search_params
    params[:search]
  end
end
