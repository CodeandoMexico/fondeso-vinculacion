class ProfilesController < ApplicationController
  def show
    puts '---------------------------------------------- funds & filters ----------------------------------------------'
    render json: Fund.search_with_profile_and_filters(category_params[:category_name], filter_params, priority_params, delegation_params)
  end

  def answers
    answers = Fondeso::Answer.new
    puts '---------------------------------------------- controller logic ----------------------------------------------'
    # we need to save "everything" to the database
    # parse the data from the questionary
    questionary_answers = params[:answers]

    answers.extract_question_data_from(questionary_answers)
    # let's process the questionary answers
    winning_profile = answers.process_questionary
    puts "lets redirect to #{winning_profile.uri}"
    render json: { profile: winning_profile, filters: filter_params, priorities: priority_params, delegations: delegation_params }
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def filter_params
    params.require(:filters).permit(
      :MUJ,
      :RUR,
      :JOV,
      :TER,
      :ART,
      :TAB,
      :BAC,
      :EXP,
      :MAN,
      :PIN,
      :CON,
      :TUR,
      :ATI,
      :IND,
      :TIC
    )
  end

  def priority_params
    params.require(:priorities) if params[:priorities].present?
  end
  def delegation_params
    params.require(:delegations).permit(:home, :business) if params[:delegations].present?
  end

end
