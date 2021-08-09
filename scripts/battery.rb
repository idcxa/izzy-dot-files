#!/usr/bin/env ruby

bat1 = File.read('/sys/class/power_supply/BAT0/capacity').to_i
bat2 = File.read('/sys/class/power_supply/BAT1/capacity').to_i

bat = (bat1+bat2)/2

if bat < 13
  print(' ')
elsif bat < 38
  print(' ')
elsif bat < 63
  print(' ')
elsif bat < 83
  print(' ')
else
  print(' ')
end

print(bat.to_s + "%")
