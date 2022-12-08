# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'application'

class Interface
  attr_reader :app

  def initialize
    @app = Application.new
  end

  def create_new_station
    puts 'enter the name of the station'
    station_name = gets.chomp
    app.stations_list << Station.new(station_name)
    puts "you created new station - #{station_name}"
  end

  def create_new_train
    puts 'enter the number of the train'
    train_number = gets.chomp
    puts "enter the type of the train
          1-passenger
          2-cargo"
    train_type = gets.chomp.to_i
    add_train_by_type(train_type, train_number)
  end

  def create_new_route
    puts 'enter 1st and last stations of the road'
    puts 'enter 1st:'
    app.show_stations
    first_station = app.choosen_station(app.user_menu_input)
    puts 'enter last:'
    app.show_stations
    last_station = app.choosen_station(app.user_menu_input)
    if first_station.nil? || last_station.nil?
      error_text
    else
      app.routes_list << Route.new(first_station, last_station)
      puts "you created new route. #{Route.new(first_station, last_station).stations_names}"
    end
  end

  def add_station_to_route
    puts 'enter the route, you want to edit'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)
    puts 'enter the station, you want to add to the road'
    app.show_stations
    station = app.choosen_station(app.user_menu_input)

    if route.nil?
      error_text
    else
      puts 'we neen to find the place of the station, enter previous station'
      route.stations.each.with_index(1) do |st, number|
        puts "#{number} - #{st.name}"
      end
      puts 'введите номер - '
      station_number = gets.chomp.to_i - 1
      previous_station = app.stations_list[station_number]
      if previous_station.nil? || station.nil?
        error_text
      else
        route.add_station(station, previous_station)
        puts "New route - #{route.stations_names}"
      end
    end
  end

  def delete_station_from_route
    puts 'enter the route, you want to edit'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    puts 'enter the station, you want to delete from the road'
    app.show_stations
    station = app.choosen_station(app.user_menu_input)

    if route.nil? || station.nil?
      error_text
    else
      route.delete_station(station)
      puts "The route - #{route.stations_names}"
    end
  end

  def set_the_route_to_train
    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    puts 'enter the route, you want to set to the train'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    if route.nil? || train.nil?
      error_text
    else
      train.add_route(route)
      puts "you set the route - #{route.name} to the train - #{train.number}"
    end
  end

  def add_wagon_to_train
    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    if train.nil?
      error_text
    else
      if train.instance_of? TrainPassenger
        train.add_wagon(WagonPassenger.new)
      elsif train.instance_of? TrainCargo
        train.add_wagon(WagonCargo.new)
      end
      puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}"
    end
  end

  def remove_wagon_from_the_train
    puts 'Enter the number of train - you want to edit:'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    if train.nil?
      error_text
    else
      train.delete_wagon
      puts "you have deleted wagon from the #{train.number}, amount of wagons: #{train.wagons_amount}"
    end
  end

  def move_train_forward
    puts 'Enter the train, you want to move'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)
    if train.nil? || train.current_station.nil? || train.next_station.nil?
      error_text
    else
      train.forward
      puts "cutternt station - #{train.current_station.name}"
    end
  end

  def move_train_back
    puts 'Enter the number of train, you want to move'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    if train.nil? || train.current_station.nil? || train.previous_station.nil?
      error_text
    else
      puts train.previous_station.name
      train.backward
      puts "cutternt station - #{train.current_station.name}"
    end
  end

  private

  def add_train_by_type(train_type, train_number)
    case train_type
    when 1
      app.trains_list << TrainPassenger.new(train_number)
      puts "you created new train - #{train_number}, the type is - Passenger"
    when 2
      app.trains_list << TrainCargo.new(train_number)
      puts "you created new train - #{train_number}, the type is - Cargo"
    else
      error_text
    end
  end

  def error_text
    puts 'error, you entered wrong menu input'
  end
end
