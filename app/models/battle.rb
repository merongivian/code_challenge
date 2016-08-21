class Battle < ActiveRecord::Base
  after_create :create_games!

  has_many :game_boards

  PLAYERS = 2

  private

  def create_games!
    PLAYERS.times do
      GameBoard.create battle: self
    end
  end
end
