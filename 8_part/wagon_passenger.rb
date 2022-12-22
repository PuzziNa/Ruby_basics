# frozen_string_literal: true

require_relative 'vendor'

class WagonPassenger
  attr_accessor :passanger_quantity, :occupied_seats, :number, :free_seats

  include Vendor

  def initialize(_number, passanger_quantity)
    @passanger_quantity = passanger_quantity
    @occupied_seats ||= 0
  end

  def buy_ticket
    if @free_seats > 0
      @occupied_seats += 1
    else
      raise ArgumentError, 'wagon is full'
    end
  end

  def free_seats
    @free_seats = passanger_quantity - occupied_seats
  end
end
