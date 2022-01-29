class Board
  attr_reader :vertices
  def initialize
    @vertices = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])
  end

  def knight_moves(position, destination)
    knight = Knight.new(position)
    path = []

    until knight.position == destination
      path << knight.position
      knight = Knight.new(knight.possible_moves.sample)
    end
    path << destination

    puts "You made it in #{path.size - 1} moves! Here is your path: "
    path.each {|pos| p pos}
  end 
end

class Knight
  attr_accessor :moves, :position, :possible_moves

  def initialize(position)  
    @moves = [ [1, 2], [2, 1], [-1, 2], [2, -1], [-2, -1], [-1, -2], [-2, 1], [1, -2] ]
    @position = position
    @possible_moves = generate_possible_moves
  end

  def generate_possible_moves
    result = []

    @moves.each do |move|
      if (move[0] + @position[0]).between?(0, 7) && (move[1] + @position[1]).between?(0, 7)
        result << [@position[0] + move[0], @position[1] + move[1]]
      end
    end
    result
  end
end

board = Board.new

board.knight_moves([0, 0], [1, 2])