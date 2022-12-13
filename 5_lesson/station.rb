require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def all
    @stations
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
end
