module ApplicationHelper
  # --------------------------------- User is Current User ---------------------------------
  def current_user?(user)
    current_user == user
  end

end
