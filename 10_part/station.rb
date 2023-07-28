# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[a-z]{3,}$/i.freeze

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

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
end
