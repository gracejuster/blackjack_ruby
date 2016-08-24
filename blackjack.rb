require "byebug"



### DECK CLASS ###
class Deck
  attr_accessor :cards
  def initialize
    #a deck is a shuffled array of 52 cards (four of 13 different cards)
    @cards = []
    makeDeck
    shuffleDeck
  end

  def makeDeck
    #deck contains four of each card number 
    nums = [2,3,4,5,6,7,8,9,10,10,10,10,11]
    nums.each do |num|  
      4.times do 
       @cards << num
      end 
    end
  end

  def shuffleDeck
    #deck of cards is shuffled 
    @cards = @cards.shuffle
  end 

end

### PLAYER CLASS ###
class Player
  attr_accessor :hand, :name, :bust

  def initialize(name)
    @hand = []
    @name = name
    @bust = false
  end

end

### BLACKJACK ###
class Blackjack
  attr_accessor :deck, :player1, :player2

  def initialize
    @deck = Deck.new
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
  end

  #pull card from top of deck 
  def pull_card
    @deck.cards.pop
  end

  #deal two cards to two players 
  def deal_cards(playerA, playerB)  
    2.times do 
      deal_card(playerA)
      deal_card(playerB)
    end 
  end 

  #deal one card to one player 
  def deal_card(player)
    player.hand << pull_card
  end 

  #total the value of a player's cards
  def handTotal(player)
    player.hand.reduce(:+)
  end
  
  #keep dealing cards to a player as long as their hand is less than 16
  #change bust status once hand is greater than 21
  def keep_dealing(player)
    while handTotal(player) <= 16
      deal_card(player)
    end 
    if handTotal(player) > 21
      player.bust = true
    end 
  end

  #print result of winner with their score 
  def announce_winner(player)
    puts "#{player.name} wins with a score of #{handTotal(player)}"
  end

  #print result of loser with their score 
  def announce_loser(player)
     puts "#{player.name} loses with a score of #{handTotal(player)}"
  end

  #determine which player one 
  def outcome(playerA, playerB)
      #if both players have not busted and their total hand is the same --> tie 
      if playerA.bust == false && playerB.bust == false && handTotal(playerA) == handTotal(playerB)
          puts "#{playerA.name} and #{playerB.name} tied with a score of #{handTotal(playerA)}"
      #if both players bust --> both loose 
      elsif playerA.bust == true && playerB.bust == true 
          puts "#{playerA.name} and #{playerB.name} both busted"
      #if playerA has not busted and playerB has --> playerA wins 
      elsif playerA.bust == false && playerB.bust == true 
          announce_winner(playerA)
          announce_loser(playerB)
      #if playerB has not busted and playerA has --> playerB wins 
      else playerB.bust == false && playerA.bust == true 
          announce_winner(playerB)
          announce_loser(playerA)
      end
  end

  def run
    deal_cards(@player1, @player2)
    keep_dealing(@player1)
    keep_dealing(@player2)
    outcome(@player1, @player2)
  end

end

### RUN PROGRAM ###

# make a new game
game = Blackjack.new

# run the game
game.run
