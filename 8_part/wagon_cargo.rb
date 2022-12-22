# frozen_string_literal: true

require_relative 'vendor'

class WagonCargo
  attr_accessor :space, :occupied_space, :number, :free_space

  include Vendor

  def initialize(number, space)
    @number = number
    @space = space
    @occupied_space ||= 0
  end

  def occupy_space(volume)
    if @free_space - volume > 0
      @occupied_space += volume
    else
      raise ArgumentError, 'not enough space'
    end
  end

  def free_space
    @free_space = space - occupied_space
  end
end
