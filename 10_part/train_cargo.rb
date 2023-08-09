# frozen_string_literal: true

class TrainCargo < Train
  include InstanceCounter

  validate :number, :format, ID_FORMAT

  def valid_type?(wagon)
    wagon.instance_of? WagonCargo
  end
end
