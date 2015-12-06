class Robot
  attr_reader :name,
              :serial_number,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department

  def initialize(data)
    @name          = data[:name]
    @serial_number = data[:serial_number]
    @city          = data[:city]
    @state         = data[:state]
    @avatar        = data[:avatar]
    @birthdate     = data[:birthdate]
    @date_hired    = data[:date_hired]
    @department    = data[:department]
  end

  def dob_year
    unformatted_birthdate[0].to_i
  end

  def dob_month
    unformatted_birthdate[1].to_i
  end

  def dob_day
    unformatted_birthdate[2].to_i
  end

  def unformatted_birthdate
    birthdate.split("-")
  end

  def hired_year
    date_hired.split("-").first.to_i
  end

  def get_stat(parameter)
    case parameter
    when "hired_year"
      hired_year
    when "department"
      department
    when "city"
      city
    when "state"
      state
    end
  end
end
