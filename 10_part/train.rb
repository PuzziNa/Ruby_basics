# frozen_string_literal: true

require_relative 'vendor'
require_relative 'validation'

class Train
  extend Vendor
  include Validation

  ID_FORMAT = /^[a-z|\d]{3}$|[a-z|\d]{3}-{1}[a-z|\d]{2}$/.freeze

  attr_reader :number, :wagons, :current_station, :speed

  validate :name, :presence
  validate :name, :format, ID_FORMAT

  @@all_trains = []

  def self.all
    @@all_trains
  end

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
    @wagons.push(wagon) if @speed.zero?
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
    return unless @current_station != @route.first_station

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
end
