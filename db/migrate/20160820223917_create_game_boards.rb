class CreateGameBoards < ActiveRecord::Migration
  def change
    create_table :game_boards do |t|
      t.belongs_to :battle

      t.timestamps
    end
  end
end
