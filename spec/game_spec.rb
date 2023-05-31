RSpec.describe Game do
  let(:game) { Game.new('Game Name', '2022-01-01', '2022-01-01', 'Yes') }

  describe '#initialize' do
    it 'sets the game_name' do
      expect(game.game_name).to eq('Game Name')
    end

    it 'sets the multiplayer' do
      expect(game.multiplayer).to eq('Yes')
    end

    it 'sets the last_played_at' do
      expect(game.last_played_at).to eq('2022-01-01')
    end

    it 'sets the publish_date' do
      expect(game.publish_date).to eq(Date.parse('2022-01-01'))
    end
  end

  describe '#move_to_archive' do
    context 'when the game is older than 2 years' do
      let(:game) { Game.new('Game Name', '2020-01-01', '2022-01-01', 'Yes') }

      it 'moves the game to archive' do
        game.move_to_archive
        expect(game.archived).to be true
      end
    end

    context 'when the game is newer than 2 years' do
      let(:game) { Game.new('Game Name', '2022-01-01', '2022-01-01', 'Yes') }

      it 'does not move the game to archive' do
        game.move_to_archive
        expect(game.archived).to be nil
      end
    end
  end

  describe '#can_be_archived?' do
    context 'when the game is older than 2 years' do
      let(:game) { Game.new('Game Name', '2020-01-01', '2022-01-01', 'Yes') }

      it 'returns true' do
        expect(game.send(:can_be_archived?)).to be true
      end
    end

    context 'when the game is newer than 2 years' do
      let(:game) { Game.new('Game Name', '2022-01-01', '2022-01-01', 'Yes') }

      it 'returns false' do
        expect(game.send(:can_be_archived?)).to be false
      end
    end
  end
end
