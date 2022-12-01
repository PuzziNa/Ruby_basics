class Station
  attr_reader :name, :trains, :passangers_trains, :trains_by_type

  def initialize(name)
    @name = name
    @trains = []
    @trains_by_type = { passenger: [], cargo: [] }
  end

  def add_train(train)
    trains << train
    if train.type == :passenger
      @trains_by_type[:passenger] << train
    else
      @trains_by_type[:cargo] << train
    end
  end

  def move_train(train)
    trains.delete(train)
  end
end
