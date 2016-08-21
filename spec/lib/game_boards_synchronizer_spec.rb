require 'rails_helper'

RSpec.describe GameBoardsSynchronizer do
  let!(:battle) { create(:battle) }
  let(:my_board) { battle.game_boards.first }
  let(:opponent_board) {  battle.game_boards.last }

  let(:synchronizer) do
    described_class.new(my_board: my_board, opponent_board: opponent_board)
  end

  describe '#attack_cell!' do
    let(:x_position) { 0 }
    let(:y_position) { 0 }

    let!(:my_cell) do
      Cell.find_by(x_position: x_position,
                   y_position: y_position,
                   game_board: my_board)
    end
    let!(:opponent_cell) do
      Cell.find_by(
        x_position: x_position,
        y_position: y_position,
        game_board: opponent_board
      )
    end

    before do
      my_cell.update_attributes(hitted: hitted)
      opponent_cell.update_attributes(has_ship: opponent_has_ship)
    end

    context 'for not yet setted cell' do
      let(:hitted) { nil }

      context "when opponent ship is hitted" do
        let(:opponent_has_ship) { true }

        it 'marks my board as hitted opponent' do
          synchronizer.attack_cell! x_position, y_position
          expect(my_cell).to be_hitted
        end

        it 'should be in a setted state' do
          synchronizer.attack_cell! x_position, y_position
          expect(my_cell).to be_setted
        end
      end

      context "when opponent ship is not hitted" do
        let(:opponent_has_ship) { false }

        it 'marks my board as not hitted opponent' do
          synchronizer.attack_cell! x_position, y_position
          expect(my_cell).to_not be_hitted
        end

        it 'should be in a setted state' do
          synchronizer.attack_cell! x_position, y_position
          expect(my_cell).to be_setted
        end
      end
    end

    context 'for already setted cell' do
      let(:hitted) { false }

      it 'should conserve previous value' do
        synchronizer.attack_cell! x_position, y_position
        expect(my_cell).to_not be_hitted
      end
    end
  end
end
