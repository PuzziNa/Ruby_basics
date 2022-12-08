# frozen_string_literal: true

class Route
  attr_reader :first_station, :last_station, :stations, :name

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
  end

  def add_station(station, previous_station)
    station_number = @stations.find_index(previous_station) + 1

    if previous_station != last_station
      stations.insert(station_number, station)
    else
      puts 'Error this is a last station!'
    end
  end

  def delete_station(station)
    if station != @last_station && station != @first_station
      stations.delete(station)
    else
      puts 'Error, you cant delete first or last station!'
    end
  end

  def stations_names
    stations.map(&:name)
  end
end
