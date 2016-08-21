class CellsController < ApplicationController
  def update
    @cell = Cell.find(params[:id])
    @cell.attack!
  end
end
