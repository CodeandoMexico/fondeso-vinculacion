class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  layout "fondesofundlist"

  def index
    if current_user.has_a_saved_questionary?
      answers = current_user.answers
      category = current_user.category
      filters = current_user.filters
      priorities = current_user.priorities
      delegations = current_user.delegations

      @funds = Fund.search_with_profile_and_filters(category["uri"], filters, priorities, delegations)
      current_user.update_his_information(@funds)
    else
      redirect_to questionary_index_path
    end
  end

  def create
    prepare_user_submission_with params

    if current_user.save
      UserMailer.questionary_submitted(current_user).deliver
      redirect_to profiles_path
    else
      redirect_to questionary_index_path
    end
  end

  def destroy
    if current_user.update(questionary: nil)
      redirect_to questionary_index_path
    else
      redirect_to profiles_path
    end
  end

  def answers
    if tie_params.present?
      tie = Fondeso::Answer.new
      # solve the tie first
      tie.extract_question_data_from(tie_params)
      winning_profile = tie.solve_tie_in(profile_params, tie.answers)
      puts "tie detected"
    else
      answers = Fondeso::Answer.new
      answers.extract_question_data_from(answer_params)

      # Process the questionary answers. If this returns an array, it's a tie, between those profiles
      winning_profile = answers.process_questionary
      puts "winner has been chosen"
    end
    render json: { profile: winning_profile, filters: filter_params, priorities: priority_params, delegations: delegation_params }
  end

  private

  def prepare_user_submission_with(params)

    special_case = params[:special_case]

    current_user.answers = sanitize params[:answers]
    current_user.category = special_case.blank? ? sanitize(params[:category_name]) : sanitize(special_case)
    current_user.filters = sanitize params[:filters]
    current_user.priorities = sanitize params[:priorities]
    current_user.delegations = sanitize params[:delegations]
  end

  def category_params
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
