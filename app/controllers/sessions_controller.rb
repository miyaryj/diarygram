include InstagramHelper

class SessionsController < Devise::SessionsController

  def destroy
    clear_access_token
    super
  end

end
