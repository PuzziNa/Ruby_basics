# frozen_string_literal: true

class TrainPassenger < Train
  def valid_type?(wagon)
    wagon.instance_of? WagonPassenger
  end
end
