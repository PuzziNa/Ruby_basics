# frozen_string_literal: true

class TrainCargo < Train
  def valid_type?(wagon)
    wagon.instance_of? WagonCargo
  end
end
