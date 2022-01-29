class Board
  attr_reader :vertices
  def initialize
    @vertices = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])
  end

  def knight_moves(position, destination = nil)
    knight = Knight.new(position)
    p knight.possible_moves
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

board.knight_moves([0, 0])