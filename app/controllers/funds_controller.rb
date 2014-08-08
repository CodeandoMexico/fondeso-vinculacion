class FundsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if search_params.present?
      @funds = Fund.search(search_params).order('created_at DESC').page(params[:page])
    else
      @funds = Fund.all.order('created_at DESC').page(params[:page])
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

  # establish a connection with the server
  def handshake
    render nothing: true
  end

  def show
    if request.get?
      funds = Fondeso::Fund.new
      render json: funds.all
    end
  end

  def category
    funds = Fondeso::Fund.new
    # look for funds in this category
    category = params[:name]
    stage = params[:stage]
    results = funds.find(category, stage)
    options = results.length > 0 ? { json: results } : { json: [], status: :not_found }
    render options
  end

  def answers
    # c = params["1.B"]
    # puts c
    if request.post?
      answers = Fondeso::Answer.new
      puts '---------------------------------------------- controller logic ----------------------------------------------'
      # we need to save everything to the database
      # parse the data from the questionary
      answers.extract_question_data_from(params[:_json])
      # let's process the questionary answers
      winning_profile = answers.process_questionary
      puts "lets redirect to #{winning_profile.uri}"
    end
    render json: winning_profile
  end

  private

  def set_user
    @fund = Fund.find(params[:id])
  end

  def fund_params
    params.require(:fund).permit(
      :name,
      :institution,
      :description,
      :home_delegation,
      :business_delegation,
      characteristics: [],
      deliver_method: [],
      clasification: [],
      special_filters: [],
    )
  end

  def search_params
    params[:search]
  end
end
