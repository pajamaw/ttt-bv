#!/usr/bin/env ruby
require_relative '../config/environment.rb'

g = Game.new(Board.new(5))
g.play
