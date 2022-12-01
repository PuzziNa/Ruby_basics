class Train
  attr_reader :number, :type, :wagons_amount, :speed, :current_station

  def initialize(number, type, wagons_amount)
    @number = number
    @wagons_amount = wagons_amount
    @speed = 0
    @type = assign_type(type)
  end

  def assign_type(type)
    valid_types = %i[passenger cargo]

    return type if valid_types.include?(type)

    puts "#{type} train can not be recieved"
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons_amount += 1
  end

  def delete_wagon
    @wagons_amount -= 1
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def forward
    @current_station = next_station
  end

  def backward
    @current_station = previous_station
  end

  def previous_station
    station_index = @route.stations.find_index(@current_station) - 1
    @route.stations[station_index]
  end

  def next_station
    station_index = @route.stations.find_index(@current_station) + 1
    @route.stations[station_index]
  end
end
