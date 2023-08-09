# frozen_string_literal: true

class TrainPassenger < Train
  include InstanceCounter

  validate :number, :format, ID_FORMAT

  def valid_type?(wagon)
    wagon.instance_of? WagonPassenger
  end
end
