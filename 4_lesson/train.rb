# frozen_string_literal: true

class Train
  attr_reader :number, :wagons, :speed
  attr_accessor :current_station

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons.push(wagon) if @speed.zero? && valid_type?(wagon)
  end

  def delete_wagon
    @wagons.pop if @speed.zero? && wagons_amount > 0
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def forward
    if @current_station != @route.last_station
      @current_station.remove_train(self)
      @current_station = next_station
      @current_station.add_train(self)
    end
  end

  def backward
    if @current_station != @route.first_station
      @current_station.remove_train(self)
      @current_station = previous_station
      @current_station.add_train(self)
    end
  end

  def previous_station
    if @current_station != @route.first_station
      station_index = @route.stations.find_index(@current_station) - 1
      @route.stations[station_index]
    end
  end

  def next_station
    station_index = @route.stations.find_index(@current_station) + 1
    @route.stations[station_index] unless @route.stations[station_index].nil?
  end

  def wagons_amount
    @wagons.length
  end
end
