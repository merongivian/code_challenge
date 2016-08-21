class GameBoard < ActiveRecord::Base
  after_create :create_cells!
  after_create :set_synchronizer

  belongs_to :battle

  has_many :cells

  BOARD_SIZE = 10
  SHIPS = 40

  def attack!(cell)
    @synchronizer.attack_cell!(cell)
  end

  private

  def create_cells!
    (0..(BOARD_SIZE-1)).to_a.repeated_permutation(2).to_a.each do |coordinate|
      Cell.create(
        x_position: coordinate[0],
        y_position: coordinate[1],
        game_board: self
      )
    end

    create_random_ships!
  end

  def create_random_ships!
    SHIPS.times do
      board_range = (0..(BOARD_SIZE-1)).to_a
      cell = Cell.find_by(x_position: board_range.sample,
                          y_position: board_range.sample,
                          game_board: self)

      if cell.has_ship?
        redo
      else
        cell.update_attributes has_ship: true
      end
    end
  end

  def set_synchronizer
    @synchronizer = GameBoardsSynchronizer.new(
      my_board: self,
      opponent_board: self.battle.game_boards.where.not(id: self.id).first
    )
  end
end
