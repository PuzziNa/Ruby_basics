# frozen_string_literal: true

class TrainPassenger < Train
  include InstanceCounter

  validate :wagon, :type, WagonPassenger
end
