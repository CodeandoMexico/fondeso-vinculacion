class ProfilesController < ApplicationController
  def show
    # raise current_user.inspect
    # puts category_params
    puts '------------------------------ Hello ------------------------------'
    # raise current_user.inspect
    # authenticity_token = sanitize params[:authenticity_token]
    answers = sanitize params[:answers]
    category_name = sanitize params[:category_name]
    filters = sanitize params[:filters]
    priorities = sanitize params[:priorities]
    delegations = sanitize params[:delegations]

    @funds = Fund.search_with_profile_and_filters(category_name["uri"], filters, priorities, delegations)
    # raise @funds.inspect
    # render json: Fund.search_with_profile_and_filters(category_params[:category_name], filter_params, priority_params, delegation_params)
  end

  def answers
    if tie_params.present?
      tie = Fondeso::Answer.new
      # solve the tie first
      tie.extract_question_data_from(tie_params)
      winning_profile = tie.solve_tie_in(profile_params, tie.answers)
      puts "tie detected"
    else
      # we need to save "everything" to the database
      # parse the data from the questionary
      # questionary_answers = params[:answers]

      answers = Fondeso::Answer.new
      answers.extract_question_data_from(answer_params)
      # Process the questionary answers. If this returns an array, it's a tie, between those profiles
      winning_profile = answers.process_questionary
      puts "winner has been chosen"
    end
    render json: { profile: winning_profile, filters: filter_params, priorities: priority_params, delegations: delegation_params }
  end

  private

  def category_params
    # params.permit(:category_name)
    params[:category_name]
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

  def answer_params
    params[:answers]
  end

  def priority_params
    params.require(:priorities) if params[:priorities].present?
  end
  def delegation_params
    params.require(:delegations).permit(:home, :business) if params[:delegations].present?
  end

  def tie_params
    params[:tie]
  end

  def profile_params
    params[:profiles]
  end

  def sanitize(parameters)
    JSON.parse(parameters)
  end
end
