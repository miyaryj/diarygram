module EntriesHelper

  def store_action_to_continue(action)
    session[:action_to_continue] = action
  end

  def clear_action_to_continue
    session.delete(:action_to_continue)
  end

  def action_to_continue(default: {controller: :entries, action: :new})
    session[:return_to_after_instagram] || default
  end
end
