# frozen_string_literal: true

class Board
  def initialize
    @moves = [[1, 2], [2, 1], [-1, 2], [2, -1], [-2, -1], [-1, -2], [-2, 1], [1, -2]]
  end

  def knight_moves(position, destination, current = generate_possible_moves(position))
    path = []
    result = level_order(current)
    path << current.position
    i = 0
    until result.include?(destination)
      break if current.possible_moves[i].nil?
      current = generate_possible_moves(current.possible_moves[i].position)
      path << current.position
      result = level_order(current)
      i += 1
    end
    path << destination
    puts "You made it in #{path.size - 1} moves! Here is your path: "
    path.each { |pos| p pos }
  end

  def generate_possible_moves(position)
    knight = Knight.new(position)
    @moves.each do |move|
      if (move[0] + knight.position[0]).between?(0, 7) && (move[1] + knight.position[1]).between?(0, 7)
        knight.possible_moves << Knight.new([knight.position[0] + move[0], knight.position[1] + move[1]])
      end
    end

    knight
  end

  def level_order(current = nil, queue = [], list = [])
    return if current.nil?

    queue.push << current

    until queue.empty?
      current = queue.first
      list.push(current.position)

      8.times do |i|
        queue.push(current.possible_moves[i]) unless current.possible_moves[i].nil?
      end
      queue.shift
    end
    list
  end
end

class Knight
  attr_accessor :position, :possible_moves

  def initialize(position)
    @position = position
    @possible_moves = []
  end
end

board = Board.new

board.knight_moves([3, 3], [0, 0])
