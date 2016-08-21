class GamesController < ApplicationController
  def show
    @game = GameBoard.find(params[:id])
  end
end
