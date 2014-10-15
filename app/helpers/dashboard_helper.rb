module DashboardHelper
  NOT_AVAILABLE = "N/A"
  def pretty_delegation_format(user, key)
    if user.has_answered_a_questionary? && user.delegations[key].present?
      user.delegations[key]
    else
      NOT_AVAILABLE
    end
  end

  def pretty_user_profile(user)
    if user.has_answered_a_questionary?
      user.category[:uri]
    else
      NOT_AVAILABLE
    end
  end

  def pretty_data(data)
    if data.present?
      data
    else
      NOT_AVAILABLE
    end
  end

end
