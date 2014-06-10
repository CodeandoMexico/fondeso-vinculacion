class FundsController < ApplicationController
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
    category_funds = funds.find(params[:name])
    render json: category_funds
  end

  def answers
    # c = params["1.B"]
    # puts c
    render nothing: true
  end

end
