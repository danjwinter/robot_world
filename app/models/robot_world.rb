require 'yaml/store'
require 'pony'

class RobotWorld
  def self.database
    if ENV["RACK_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/robot_world_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_world_development.sqlite3")
    end
  end

  def self.database_access
    database.from(:robots)
  end

  def self.create(robot)
    database_access.insert(robot)


    Pony.mail({:to => 'dan.j.winter@gmail.com', :subject => "Robot Assembled", :from => 'me@example.com', :body => 'robot created'})
    # database.transaction do
    #   database['robots'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['serial_number'] ||= 0
    #   database['serial_number'] += 1
    #   database['robots'] << { "serial_number" => database['serial_number'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department] }
    # end
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_robots = database_access.to_a
    raw_robots.map {|data| Robot.new(data)}
  end

  def self.raw_robot(serial_number)
    raw_robots.find {|robot| robot["serial_number"] == serial_number}
  end

  def self.find(serial_number)
    data = database_access.where(serial_number: serial_number).to_a.first
    Robot.new(data)
  end

  def self.update(serial_number, robot)
    database_access.where(serial_number: serial_number).update(robot)
  end

  def self.delete(serial_number)
    database_access.where(serial_number: serial_number).delete
  end

  def self.delete_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
      database['serial_number'] = 0
    end
  end

  def self.average_age
    today = Date.today
    all.inject(0) do |sum, robot|
      age = today.year - robot.dob_year
      robot.dob_month > today.month || (robot.dob_month >= today.month && robot.dob_day > today.day)? age -= 1 : nil
      sum + age
    end / all.count
  end

  def self.count_in(parameter)
    counts = Hash.new(0)
    all.map do |bot|
      bot.get_stat(parameter)
    end.each {|year| counts[year] += 1}
    counts
  end
end


# Create your own Sinatra app from scratch. This app should be a directory of robots. A robot has a name, city, state, avatar, birthdate, date hired, and department. Program the CRUD functionality for robots so that we can see all robots, see one specific robot, edit/update a robot, create a robot, and delete a robot. Use http://robohash.org/ for pictures. Add a dashboard that shows statistical data: average robot age, a breakdown of how many robots were hired each year, and number of robots in each department/city/state.