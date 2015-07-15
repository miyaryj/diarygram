module ApplicationHelper
  def current_tab(tab)
    @tab = tab
  end

  def current_tab?(tab)
    @tab == tab
  end
end
