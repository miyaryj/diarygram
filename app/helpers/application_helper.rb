module ApplicationHelper

  def current_tab(tab)
    @tab = tab
  end

  def current_tab_index
    case @tab
    when :timeline
      "0"
    when :calendar
      "1"
    end
  end

  def current_tab?(tab)
    @tab == tab
  end
end
