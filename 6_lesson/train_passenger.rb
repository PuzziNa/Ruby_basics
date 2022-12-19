# frozen_string_literal: true

class TrainPassenger < Train
  include InstanceCounter

  def valid_type?(wagon)
    wagon.instance_of? WagonPassenger
  end
end
