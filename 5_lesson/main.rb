# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'application'
require_relative 'interface'
require_relative 'vendor'
require_relative 'instance_counter'

interface = Interface.new

loop do
  puts '
        What action do you want to do (put the number):

        1-create new station
        2-create a new train
        3-create a new route
        4-add station on the route
        5-delete station on the route
        6-set the route to the train
        7-add wagon to the train
        8-remove wagon from the train
        9-move the train forward
        10-move the train  back
        11-the list of stations & the list of the trains on the station
        12-exit'
  action = gets.chomp.to_i

  case action
  when 1
    interface.create_new_station
  when 2
    interface.create_new_train
  when 3
    interface.create_new_route
  when 4
    interface.add_station_to_route
  when 5
    interface.delete_station_from_route
  when 6
    interface.set_the_route_to_train
  when 7
    interface.add_wagon_to_train
  when 8
    interface.remove_wagon_from_the_train
  when 9
    interface.move_train_forward
  when 10
    interface.move_train_back
  when 11
    interface.app.show_trains_on_the_station
  when 12
    break
  end
end
