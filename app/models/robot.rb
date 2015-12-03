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
end
