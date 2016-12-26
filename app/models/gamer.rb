class Gamer < ApplicationRecord
	has_one :wallet, dependent: :destroy
	has_many :bets

	accepts_nested_attributes_for :wallet

	after_create :set_money

	# show a full name for gamer
	def full_name
		if self.first_name && self.last_name
			self.first_name + " " + self.last_name
		elsif self.last_name
			self.last_name
		elsif self.first_name
			self.first_name
		else
			""
		end
	end

	# get all gamer with money for bets
	def self.gamer_with_money 
		self.joins('join wallets w on gamers.id = w.gamer_id').where('w.money > 0')
	end 

	private
	# set default money for new gamer
	def set_money
		wallet = Wallet.new()
		wallet.gamer_id = self.id
		wallet.money = 10000
		wallet.save
	end
end
