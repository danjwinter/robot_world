require 'yaml/store'
require_relative 'robot'

class RobotWorld
  def self.database
    @database ||= YAML::Store.new("db/robot_world")
  end

  def self.create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['serial_number'] ||= 0
      database['serial_number'] += 1
      database['robots'] << { "serial_number" => database['serial_number'], "name" => robot[:name], "city" => robot[:city], "state" => robot[:state], "avatar" => robot[:avatar], "birthdate" => robot[:birthdate], "date_hired" => robot[:date_hired], "department" => robot[:department] }
    end
  end

  def self.raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def self.all
    raw_robots.map {|data| Robot.new(data)}
  end

  def self.raw_robot(serial_number)
    raw_robots.find {|robot| robot["serial_number"] == serial_number}
  end

  def self.find(serial_number)
    Robot.new(raw_robot(serial_number))
  end

  def self.update(serial_number, robot)
    database.transaction do
      target = database['robots'].find {|data| data["serial_number"] == serial_number}
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["avatar"] = robot[:avatar]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def self.delete(serial_number)
    database.transaction do
      database['robots'].delete_if {|robot| robot["serial_number"] == serial_number}
      database['total'] -= 1
    end
  end
end


# Create your own Sinatra app from scratch. This app should be a directory of robots. A robot has a name, city, state, avatar, birthdate, date hired, and department. Program the CRUD functionality for robots so that we can see all robots, see one specific robot, edit/update a robot, create a robot, and delete a robot. Use http://robohash.org/ for pictures. Add a dashboard that shows statistical data: average robot age, a breakdown of how many robots were hired each year, and number of robots in each department/city/state.