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
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def create_new_train
    puts 'enter the number of the train'
    train_number = gets.chomp

    puts "enter the type of the train
          1-passenger
          2-cargo"
    train_type = gets.chomp.to_i

    raise ArgumentError, 'wrong type of the train' unless [1, 2].include?(train_type)

    add_train_by_type(train_type, train_number)
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def create_new_route
    puts 'enter 1st and last stations of the road'

    puts 'enter 1st:'
    app.show_stations
    first_station = app.choosen_station(app.user_menu_input)

    puts 'enter last:'
    app.show_stations
    last_station = app.choosen_station(app.user_menu_input)

    raise ArgumentError, 'station -nil' if first_station.nil? || last_station.nil?

    app.routes_list << Route.new(first_station, last_station)
    puts "you created new route. #{Route.new(first_station, last_station).stations_names}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def add_station_to_route
    puts 'enter the route, you want to edit'
    app.show_routes

    route = app.choosen_route(app.user_menu_input)

    puts 'enter the station, you want to add to the road'
    app.show_stations

    station = app.choosen_station(app.user_menu_input)

    place_for_new_station(route, station)
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def delete_station_from_route
    puts 'enter the route, you want to edit'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    puts 'enter the station, you want to delete from the road'
    app.show_stations
    station = app.choosen_station(app.user_menu_input)

    raise ArgumentError, 'nil route input' if route.nil?
    raise ArgumentError, 'nil station input' if station.nil?

    route.delete_station(station)
    puts "The route - #{route.stations_names}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def set_the_route_to_train
    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    puts 'enter the route, you want to set to the train'
    app.show_routes
    route = app.choosen_route(app.user_menu_input)

    raise ArgumentError, 'nil train input' if train.nil?
    raise ArgumentError, 'nil route input' if route.nil?

    train.add_route(route)
    puts "you set the route - #{route.name} to the train - #{train.number}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def add_wagon_to_train
    puts 'Enter wagon number'
    number = gets.chomp

    raise ArgumentError, 'number - nil' if number.nil?

    puts 'enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    raise ArgumentError, 'train - nil' if train.nil?

    if train.instance_of? TrainPassenger
      puts 'Enter passanger quantity'
      quantity = gets.chomp.to_i
      train.add_wagon(WagonPassenger.new(number, quantity))
      puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}, wagon number: #{number}, passenger seats: #{quantity}"
    elsif train.instance_of? TrainCargo
      puts 'Enter wagon space'
      space = gets.chomp.to_i
      train.add_wagon(WagonCargo.new(number, space))
      puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}, wagon number: #{number}, wagon space: #{space}"
    end
  end

  def fill_the_wagon
    puts 'Enter the number of train - you want to edit:'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    raise ArgumentError, 'train - nil' if train.nil?

    puts 'Enter the wagon you want to fill:'
    train.each_wagon { |wagon, num| puts "#{num + 1} - #{wagon.number}" }
    user_input = gets.chomp.to_i

    raise ArgumentError, 'wagon - nil' if user_input.nil?

    wagon = train.wagons[user_input - 1]

    if wagon.instance_of? WagonPassenger
      wagon.buy_ticket
      puts "wagon free seats: #{wagon.free_seats}"
    end

    if wagon.instance_of? WagonCargo
      puts 'how many space you want to occupy?'
      space = gets.chomp.to_i
      wagon.occupy_space(space)
      puts "wagon free space: #{wagon.free_space}"
    end
  end

  def remove_wagon_from_the_train
    puts 'Enter the number of train - you want to edit:'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    raise ArgumentError, 'train - nil' if train.nil?

    puts 'Enter the wagon you want to remove:'
    train.each_wagon { |wagon, num| puts "#{num + 1} - #{wagon.number}" }
    wagon = gets.chomp.to_i

    raise ArgumentError, 'wagon - nil' if wagon.nil?

    train.delete_wagon(train.wagons[wagon - 1])

    puts "you have deleted wagon from the #{train.number}, amount of wagons: #{train.wagons_amount}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def move_train_forward
    puts 'Enter the train, you want to move'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    raise ArgumentError, 'train doesnt exist' if train.nil?
    raise ArgumentError, 'station doesnt exist' if train.current_station.nil?
    raise ArgumentError, 'this is the last station' if train.next_station.nil?

    train.forward
    puts "cutternt station - #{train.current_station.name}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def move_train_back
    puts 'Enter the number of train, you want to move'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    raise ArgumentError, 'train doesnt exist' if train.nil?
    raise ArgumentError, 'station doesnt exist' if train.current_station.nil?
    raise ArgumentError, 'this is first station' if train.previous_station.nil?

    puts train.previous_station.name
    train.backward
    puts "cutternt station - #{train.current_station.name}"
  rescue ArgumentError => e
    puts "ERROR: #{e.message}"
    puts 'Please retry'
    retry
  end

  def show_trains_on_the_station
    puts 'enter the station'
    app.show_stations

    station = app.choosen_station(app.user_menu_input)

    puts 'list of trains on the station:'

    station.each_train do |train|
      puts "number #{train.number}, type: #{train.class},amount of wagons: #{train.wagons_amount}"
      train.each_wagon do |wagon|
        puts 'list of wagons on this train'
        if wagon.instance_of? WagonPassenger
          puts "wagon N: #{wagon.number},occupied seats #{wagon.occupied_seats}, free seats: #{wagon.free_seats},wagon type: #{wagon.class}"
        end
        if wagon.instance_of? WagonCargo
          puts "wagon N: #{wagon.number},occupied space #{wagon.occupied_volume}, free space: #{wagon.free_volume}, wagon type: #{wagon.class}"
        end
      end
    end
  end

  def show_wagons_on_the_train
    puts 'Enter the train'
    app.show_trains
    train = app.choosen_train(app.user_menu_input)

    train.each_wagon do |wagon|
      puts 'list of wagons on this train'
      if wagon.instance_of? WagonPassenger
        puts "wagon N: #{wagon.number},occupied seats #{wagon.occupied_seats}, free seats: #{wagon.free_seats},wagon type: #{wagon.class}"
      end
      if wagon.instance_of? WagonCargo
        puts "wagon N: #{wagon.number},occupied space #{wagon.occupied_volume}, free space: #{wagon.free_volume}, wagon type: #{wagon.class}"
      end
    end
  end

  private

  def add_train_by_type(train_type, train_number)
    raise ArgumentError, 'train type - nill' if train_type.nil?
    raise ArgumentError, 'train number - nill' if train_number.nil?

    case train_type
    when 1
      app.trains_list << TrainPassenger.new(train_number)
      puts "you created new train - #{train_number}, the type is - Passenger"
    when 2
      app.trains_list << TrainCargo.new(train_number)
      puts "you created new train - #{train_number}, the type is - Cargo"
    end
  end

  def place_for_new_station(route, station)
    puts 'we neen to find the place of the station, enter previous station'
    raise ArgumentError, 'route - nill' if route.nil?
    raise ArgumentError, 'station - nill' if station.nil?

    route.stations.each.with_index(1) do |st, number|
      puts "#{number} - #{st.name}"
    end

    puts 'введите номер - '
    station_number = gets.chomp.to_i - 1
    previous_station = app.stations_list[station_number]

    route.add_station(station, previous_station)
    puts "New route - #{route.stations_names}"
  end
end
