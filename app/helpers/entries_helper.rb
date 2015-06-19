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

  def entries_of_month(user, date_of_month)
    month = date_of_month.to_s.rpartition('-')[0]
    p month
    user.entries.where("date like '%#{month}%'")
  end

  def entries_calendar(entries)
    hash = {}
    entries.each do |entry|
      if hash.has_key?(entry.date)
        hash[entry.date] << entry
      else
        hash[entry.date] = [entry]
      end
    end
    hash
  end
end
