# frozen_string_literal: true

class Train
  extend Vendor

  attr_reader :number, :wagons, :speed, :current_station

  # rubocop:disable Style/ClassVars
  @@all_trains = []

  def self.all
    @@all_trains
  end
  # rubocop:enable Style/ClassVars

  def self.find(number)
    @@all_trains.each do |train|
      return train if train.number == number
    end
  end

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@all_trains << self
  end

  def each_wagon(&block)
    wagons.each.with_index(&block)
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

  def delete_wagon(wagon)
    wagons.delete(wagon) if @speed.zero?
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def forward
    return unless @current_station != @route.last_station

    @current_station.remove_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def backward
    return unless @current_station != @route.first_station

    @current_station.remove_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def previous_station
    ireturn unless @current_station != @route.first_station

    station_index = @route.stations.find_index(@current_station) - 1
    @route.stations[station_index]
  end

  def next_station
    station_index = @route.stations.find_index(@current_station) + 1
    @route.stations[station_index] unless @route.stations[station_index].nil?
  end

  def wagons_amount
    @wagons.length
  end

  private

  def valid?
    @number =~ /^[a-z|\d]{3}$|[a-z|\d]{3}-{1}[a-z|\d]{2}$/
  end

  def validate!
    raise ArgumentError, 'Train number is invalid' unless valid?
  end
end
