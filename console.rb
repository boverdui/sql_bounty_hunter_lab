require('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new(
  {
    'name' => 'Arthur',
    'bounty_value' => '100',
    'danger_level' => 'high',
    'favourite_weapon' => 'samurai_sword'
  }
)

bounty2 = Bounty.new(
  {
    'name' => 'Bert',
    'bounty_value' => '50',
    'danger_level' => 'medium',
    'favourite_weapon' => 'poison'
  }
)

binding.pry

nil
