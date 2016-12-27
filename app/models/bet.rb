class Bet < ApplicationRecord
  belongs_to :gamer
  belongs_to :round
end
