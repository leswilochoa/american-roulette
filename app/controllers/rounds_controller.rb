class RoundsController < ApplicationController
	require 'open-uri'

	@@top_bets_percentage = 0.15
	@@floor_bets_percentage = 0.08
	@@container_bets = []

	def new
		@rounds = Round.all
	end

	def create
		gamer_bets
		if @@container_bets.any?
			@round = Round.new
			@round.result = get_color
			@round.save
			@@container_bets.each do |bet|
				bet.round_id = @round.id
				bet.amount_won = pay_win(bet, @round.result)
				bet.save
			end
			respond_to do |format|
				format.html { render :new, notice: 'Resultado de la ronda.' }
			end
		else
			respond_to do |format|
				format.html { render :new, notice: 'Ningún jugador aposto a esta ronda por falta de dinero.' }
			end
		end
	end

	def get_color #generate rand color for the game
		result = rand(1..100).round(2).to_i
		case result
		when 1..2 #probability for green color 2%
			"green"
		when 3..51 #probability for red color 49%
			"red"
		else #probability for black color 49%
			"black"
		end
	end

	private

	#get weather for the next week
	def get_weather
		bet_discrete = false
		weather_response = open('https://api.darksky.net/forecast/9997fed57baa9664ce7817037eed5024/-33.4449336,-70.6568987?lang=es&units=si&exclude=currently,minutely,hourly,alerts,flags')
		response_string = ""
		weather_response.each do |line|
		  response_string << line
		end
		weather = JSON.parse(response_string)

		weather["daily"]['data'].each do |day|
			if day['temperatureMax'] > 29
				bet_discrete = true
			end
		end
		bets_percentage(bet_discrete)
	end

	#change percentage limits for bets if weather conditions are true
	def bets_percentage bet_discrete
		@@top_bets_percentage = 0.10 if bet_discrete
		@@floor_bets_percentage = 0.04 if bet_discrete
	end

	# create bet gamer for current round
	def gamer_bets
		get_weather
		@gamers = Gamer.gamer_with_money
		@@container_bets = []
		@gamers.each do |gamer|
			bet = Bet.new
			bet.gamer_id = gamer.id
			if gamer.wallet.money > 1000
				bets_percentage_choice = rand(@@floor_bets_percentage..@@top_bets_percentage).round(2)
				bet.amount = gamer.wallet.money * bets_percentage_choice
			else
				bet.mount = gamer.wallet.money
			end
			bet.choice = get_color
			@@container_bets << bet
		end
	end

	def pay_win(bet, result)
		if bet.choice == result
			case result
			when "red", "black" 
				bet.gamer.wallet.money += bet.amount*2
				won_amount = bet.amount*2
			else
				bet.gamer.wallet.money += bet.amount*15
				won_amount = bet.amount*15
			end
		else
			bet.gamer.wallet.money -= bet.amount
			won_amount = 0
		end
		bet.gamer.wallet.save
		return won_amount
	end
end
