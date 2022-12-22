class Application
  attr_accessor :stations_list, :trains_list, :routes_list

  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  def user_menu_input
    puts 'Please input menu number:'
    gets.chomp.to_i - 1
  end

  def choosen_station(number)
    @stations_list[number]
  end

  def choosen_train(number)
    @trains_list[number]
  end

  def choosen_route(number)
    @routes_list[number]
  end

  def show_stations
    stations_list.each.with_index(1) do |station, number|
      puts "#{number} - #{station.name}"
    end
  end

  def show_trains
    trains_list.each.with_index(1) do |train, number|
      puts "#{number} - #{train.number}, #{train.class}"
    end
  end

  def show_routes
    routes_list.each.with_index(1) do |route, number|
      puts "#{number} - #{route.stations_names}"
    end
  end

  def show_trains_on_the_station
    stations_list.each.with_index(1) do |station, number|
      puts "#{number} - #{station.name}, #{station.show_trains}"
    end
  end
end
