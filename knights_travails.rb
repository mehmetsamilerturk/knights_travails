class Board
  attr_accessor :root_node

  def initialize
    @moves = [[1, 2], [2, 1], [-1, 2], [2, -1], [-2, -1], [-1, -2], [-2, 1], [1, -2]]
    @history = []
    @root_node = nil
  end

  def knight_moves(position, destination)
    @root_node = Knight.new(position)
    queue = [@root_node]
    current = queue.shift
    @history << current.position
    populate_possible_moves(current)

    until current.position == destination
      current.possible_moves.each do |pmove|
        queue << pmove
      end

      current = queue.shift
      @history << current.position
      populate_possible_moves(current)
    end

    path = []
    until current.position == @root_node.position
      path.unshift(current.position)
      current = current.parent
    end
    path.unshift(@root_node.position)

    puts "You made it in #{path.size - 1} moves! Here is your path: "
    path.each { |pos| p pos }
  end

  def populate_possible_moves(knight)
    @moves.each do |move|
      next unless (move[0] + knight.position[0]).between?(0, 7) && (move[1] + knight.position[1]).between?(0, 7)

      unless @history.include?(Knight.new([knight.position[0] + move[0], knight.position[1] + move[1]]).position)
        knight.possible_moves << Knight.new([knight.position[0] + move[0], knight.position[1] + move[1]], knight)
      end
    end
  end
end

class Knight
  attr_accessor :position, :possible_moves, :parent

  def initialize(position, parent = nil)
    @position = position
    @possible_moves = []
    @parent = parent
  end
end

board = Board.new

board.knight_moves([3, 3], [4, 3])
