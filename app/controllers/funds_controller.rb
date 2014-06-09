class FundsController < ApplicationController
  def index
    funds = Fondeso::Fund.new
    render json: funds.all
  end

  def category
    funds = Fondeso::Fund.new
    # look for funds in this category
    category_funds = funds.find(params[:name])
    render json: category_funds
  end
end
