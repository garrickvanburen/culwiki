class Person < ActiveRecord::Base

  has_many  :revisions

  
  def self.get_from_cookie
    Person.find_by_id(cookies[:person_id])
  end

end
