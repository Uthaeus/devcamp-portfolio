module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || guest_user
  end

  def guest_user
    OpenStruct.new(name: "Homer Simpson", 
                  first_name: "Homer", 
                  last_name: "Simpson", 
                  email: "Doh@whyyoulittle.com"
                  )
  end

end