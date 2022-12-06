# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
