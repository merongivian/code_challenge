class Cell < ActiveRecord::Base
  belongs_to :game_board

  def setted?
    hitted.present?
  end
end
