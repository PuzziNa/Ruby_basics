# frozen_string_literal: true

class TrainCargo < Train
  include InstanceCounter

  validate :wagon, :type, WagonCargo
end
