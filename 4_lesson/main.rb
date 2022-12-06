# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'application'

require 'byebug'

app = Application.new

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
        9-move the train forward or back
        10-the list of stations & the list of the trains on the station
        11-exit'
  action = gets.chomp.to_i

  case action
  when 1
    puts 'enter the name of the station'
    station_name = gets.chomp
    app.stations_list << Station.new(station_name)
    puts "you created new station - #{station_name}"

  when 2
    puts 'enter the number of the train'
    train_number = gets.chomp
    puts "enter the type of the train
          1-passenger
          2-cargo"
    train_type = gets.chomp.to_i
    case train_type
    when 1

      train_type = :passenger
      app.trains_list << TrainPassenger.new(train_number, train_type)
    when 2

      train_type = :cargo
      app.trains_list << TrainCargo.new(train_number, train_type)
    end
    puts "you created new train - #{train_number}, the type is - #{train_type}"

  when 3
    puts 'enter 1st and last stations of the road'
    puts 'enter 1st:'
    app.show_stations
    first_station = app.choosen_station(app.user_menu_input)

    puts 'enter last:'
    app.show_stations
    last_station = app.choosen_station(app.user_menu_input)
    app.routes_list << Route.new(first_station, last_station)

    puts "you created new route. #{Route.new(first_station, last_station).stations_names}"

  when 4
    puts 'enter the route, you want to edit'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)
    puts 'enter the station, you want to add to the road'
    app.show_stations
    station = app.choosen_station(app.user_menu_input)

    puts 'we neen to find the place of the station, enter previous station'

    route.stations.each.with_index(1) do |st, number|
      puts "#{number} - #{st.name}"
    end

    puts 'введите номер - '
    station_number = gets.chomp.to_i - 1
    previous_station = app.stations_list[station_number]

    route.add_station(station, previous_station)
    puts "New route - #{route.stations_names}"

  when 5
    puts 'enter the route, you want to edit'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    puts 'enter the station, you want to delete from the road'
    app.show_stations
    station = app.choosen_station(app.user_menu_input)
    route.delete_station(station)

    puts "you deleted the station. New route - #{route.stations_names}"

  when 6
    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    puts 'enter the route, you want to set to the train'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    train.add_route(route)
    puts "you set the route - #{route.name} to the train - #{train.number}"

  when 7
    puts "enter the type of the train
          1-passenger
          2-cargo"
    train_type = gets.chomp.to_i
    wagon = nil

    case train_type
    when 1
      wagon = WagonPassenger.new
    when 2
      wagon = WagonCargo.new
    else
      'error, invalid input'
    end

    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    train.add_wagon(wagon)
    puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}"

    puts 'error, not valid type' if train.valid_type?(wagon) == false

  when 8
    puts 'Enter the number of train - you want to edit:'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    train.delete_wagon
    puts "you have deleted wagon from the #{train.number}, amount of wagons: #{train.wagons_amount}"

  when 9
    puts 'Enter the number of train, you want to move'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    puts "cutternt station - #{train.current_station.name}
          previous - #{train.previous_station.name}
          next - #{train.next_station.name}
          "
    puts 'where you want to move the train
         1 - forward
         2 - back
         enter the number'
    number = gets.chomp.to_i

    case number
    when 1
      train.forward
    when 2
      train.backward
    else
      puts 'error, invalid input'
    end

    puts "You moved the train, current station is - #{train.current_station.name}"

  when 10
    app.show_trains_on_the_station

  when 11
    break
  end
end
