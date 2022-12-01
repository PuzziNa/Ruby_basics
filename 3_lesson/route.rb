class Route
  attr_reader :first_station, :last_station, :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end

  def add_station(station, previous_station)
    station_number = stations.find_index(previous_station) + 1
    stations.insert(station_number, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def show_stations
    stations.each do |station|
      puts station.name
    end
  end
end
