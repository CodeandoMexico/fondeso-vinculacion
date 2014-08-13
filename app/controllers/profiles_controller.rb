class ProfilesController < ApplicationController
  def handshake
    # establish a connection with the server
    render nothing: true
  end

  def show
    if request.get?
      render json: Fund.all
    end
  end

  def answers
    answers = Fondeso::Answer.new
    puts '---------------------------------------------- controller logic ----------------------------------------------'
    # we need to save everything to the database
    # parse the data from the questionary
    answers.extract_question_data_from(params[:_json])
    # let's process the questionary answers
    winning_profile = answers.process_questionary
    puts "lets redirect to #{winning_profile.uri}"
    render json: winning_profile
  end
end
