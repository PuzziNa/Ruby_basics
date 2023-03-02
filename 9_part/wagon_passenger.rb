# frozen_string_literal: true

require_relative 'vendor'

class WagonPassenger
  attr_reader :passanger_quantity, :occupied_seats, :number

  include Vendor

  def initialize(_number, passanger_quantity)
    @passanger_quantity = passanger_quantity
    @occupied_seats ||= 0
  end

  def buy_ticket
    raise ArgumentError, 'wagon is full' unless @free_seats.positive?

    occupied_seats + 1
  end

  def free_seats
    @free_seats = passanger_quantity - occupied_seats
  end
end
