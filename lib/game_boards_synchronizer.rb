class GameBoardsSynchronizer
  def initialize(my_board:, opponent_board: )
    @my_board = my_board
    @opponent_board = opponent_board
  end

  def attack_cell!(cell)
    my_cell = Cell.find_by(x_position: cell.x_position,
                           y_position: cell.y_position,
                           game_board: @my_board)
    opponent_cell = Cell.find_by(x_position: cell.x_position,
                                 y_position: cell.y_position,
                                 game_board: @opponent_board)

    if opponent_cell.has_ship?
      my_cell.update_attributes hitted: true
    else
      my_cell.update_attributes hitted: false
    end
  end
end
