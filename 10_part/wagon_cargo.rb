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
    raise ArgumentError, 'not enough space' unless (@free_space - volume).positive?

    @occupied_space += volume
  end

  def free_space
    @free_space = space - occupied_space
  end
end
