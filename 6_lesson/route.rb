require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :first_station, :last_station, :stations, :name

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
  end

  def add_station(station, previous_station)
    raise ArgumentError, 'Error this is wrong place for station' if previous_station == stations.last

    raise ArgumentError, 'the station alredy exist on this road!' if stations.include?(station)

    station_number = @stations.find_index(previous_station) + 1
    stations.insert(station_number, station)
  end

  def delete_station(station)
    if station == stations.first || station == stations.last
      raise ArgumentError, 'you cant delete first or last station!'
    end

    stations.delete(station)
  end

  def stations_names
    stations.map(&:name)
  end

  private

  def valid_first_and_last_stations?
    @first_station != @last_station
  end

  def validate!
    raise ArgumentError, 'First and last stations cant be the same' unless valid_first_and_last_stations?
  end
end
