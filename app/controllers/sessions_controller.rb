include InstagramHelper

class SessionsController < Devise::SessionsController
  def destroy
    clear_oauth_response
    super
  end
end
