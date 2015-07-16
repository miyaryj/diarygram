module EntriesHelper
  def store_entry_action(action)
    session[:entry_action] = action
  end

  def continue_entry_action(param)
    action = session[:entry_action] || { controller: '/entries', action: :new }
    redirect_to(action.merge(param))
    session.delete(:entry_action)
  end

  def clear_entry_action
    session.delete(:entry_action)
  end

  def entries_of_month(user, date_of_month)
    month = date_of_month.to_s.rpartition('-')[0]
    user.entries.where("date like '%#{month}%'")
  end

  def entries_calendar(entries)
    hash = {}
    entries.each do |entry|
      if hash.key?(entry.date)
        hash[entry.date] << entry
      else
        hash[entry.date] = [entry]
      end
    end
    hash
  end
end
