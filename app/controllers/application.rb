# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '4ccfedc5be378d6b047acbaf4b692d11'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :logged_in?

  def logged_in?
     cookies[:person_id]
     Person.find_by_cullect_id(cookies[:person_id]) || Person.make_from_cullect_id(cookies[:person_id])
  end

  # ------ FILTERS ------
  
  def setup_session
   redirect_to(:back)    
  end
  
  def destroy_session
    cookies[:person_id] = nil
    session[:person_id] = nil
    cookies.delete :person_id
    session[:tried_immediate] = true # don't try to log back in
    flash[:notice] = "You are now signed out."
    redirect_to(:back)    
  end
  
end
