class ProfilesController < ApplicationController
  # establish a connection with the server
  def handshake
    render nothing: true
  end

  def show
    if request.get?
      render json: Fund.all
    end
  end

  def answers
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
end
