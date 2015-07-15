module InstagramHelper
  def signed_in_to_instagram?
    return false unless session[:oauth_response]

    begin
      instagram_username = client.user.username
      return true
    rescue Instagram::BadRequest
      return false
    end
  end

  def store_location_instagram
    session[:return_to_after_instagram] = request.url
  end

  def redirect_back_instagram(default: { action: :index })
    redirect_to(session[:return_to_after_instagram] || default)
    session.delete(:return_to_after_instagram)
  end

  def set_oauth_response(response)
    session[:oauth_response] = response
  end

  def clear_oauth_response
    session.delete(:oauth_response)
  end

  def get_oauth_user
    Hashie::Mash.new(session[:oauth_response]['user']) if session[:oauth_response]
  end

  def instagram_medias
    client.user_recent_media(:self)
  end

  def instagram_media(id)
    client.media_item(id)
  end

  private

  def client
    Instagram.client(access_token: session[:oauth_response]['access_token'])
  end
end
