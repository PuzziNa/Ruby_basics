# frozen_string_literal: true

require_relative 'vendor'

class WagonCargo
  attr_reader :space, :occupied_space, :number

  include Vendor

  def initialize(number, space)
    @number = number
    @space = space
    @occupied_space ||= 0
  end

  def occupy_space(volume)
    if (@free_space - volume).positive?
      @occupied_space += volume
    else
      raise ArgumentError, 'not enough space'
    end
  end

  def free_space
    @free_space = space - occupied_space
  end
end
