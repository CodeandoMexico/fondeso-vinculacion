module DashboardHelper
  def pretty_delegation_format(user, key)
    currently_there_is_not_a_delegation = "N/A"

    if user.has_answered_a_questionary? && user.delegations[key].present?
      user.delegations[key]
    else
      currently_there_is_not_a_delegation
    end
  end

  def pretty_user_profile(user)
    currently_there_is_not_a_profile = "N/A"
    if user.has_answered_a_questionary?
      user.category[:uri]
    else
      currently_there_is_not_a_profile
    end
  end

end
