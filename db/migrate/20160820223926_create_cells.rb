class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.belongs_to :game_board
      t.integer :x_position, null: false
      t.integer :y_position, null: false
      t.boolean :has_ship, null: false, default: false
      t.boolean :hitted

      t.timestamps
    end
  end
end
