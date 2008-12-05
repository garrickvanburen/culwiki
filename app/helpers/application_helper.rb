# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logged_in_person_id
    session[:person_id]
  end

  alias logged_in? logged_in_person_id

  def logged_in_person
    Person.find_by_id(logged_in_person_id) if logged_in_person_id
  end

end
