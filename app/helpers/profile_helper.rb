module ProfileHelper

  def get_s(x)
    (x)? x : ""
  end

  def choose_display_name(user)
    if get_s(user.first_name) + " " + get_s(user.middle_name) + " " + get_s(user.last_name) != "  "
       get_s(user.first_name) + " " + get_s(user.middle_name) + " " + get_s(user.last_name)
    else
       user.username
    end
  end

  def user_age(user)
    if user.birthdate.present?
      years_passed = Date.today.year - user.birthdate.year
      if Date.today.month <= user.birthdate.month and Date.today.day < user.birthdate.day
        years_passed -1
      else
        years_passed
      end
    else
      nil
    end
  end

  def profile_details(user)
    age = (user_age(user)!=nil)? "Age " + user_age(user).to_s : ""
    details = age
    gender = (details!="")? ", " : ""
    gender = (user.gender.present?)? gender + user.gender.titleize : ""
    details = details + gender
    country = (details!="")? ", " : ""
    country =  (user.country.present?)? country + user.country.name : ""
    details = details + country
    details
  end

end
