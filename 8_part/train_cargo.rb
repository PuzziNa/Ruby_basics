# frozen_string_literal: true

class TrainCargo < Train
  include InstanceCounter

  def valid_type?(wagon)
    wagon.instance_of? WagonCargo
  end
end
