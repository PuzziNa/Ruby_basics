# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def self.all_names
    all.map(&:name)
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def each_train(&block)
    trains.each(&block)
  end

  def add_train(train)
    trains << train
  end

  def remove_train(train)
    trains.delete(train)
  end

  def passenger_trains
    trains.select { |train| train.instance_of? TrainPassenger }
  end

  def cargo_trains
    trains.select { |train| train.instance_of? TrainCargo }
  end

  def show_trains
    trains.map(&:number)
  end

  private

  def valid?
    @name.length > 3
  end

  def validate!
    raise ArgumentError, 'You didnt enter right the name' unless valid?
  end
end
