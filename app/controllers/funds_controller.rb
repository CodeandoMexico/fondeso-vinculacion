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
    options = category_funds.length > 0 ? { json: category_funds } : { json: [], status: :not_found }
    render options
  end

  def answers
    # c = params["1.B"]
    # puts c
    if request.post?
      answers = Fondeso::Answer.new
      puts '---------------------------------------------- controller logic ----------------------------------------------'
      # remove unecessary keys
      answers.parse(params[:_json])
      # we need to save everything to the database
    end
    render nothing: true
  end

end
