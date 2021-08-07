#!/usr/bin/env ruby

bat1 = File.read('/sys/class/power_supply/BAT0/capacity').to_i
bat2 = File.read('/sys/class/power_supply/BAT1/capacity').to_i

bat = (bat1+bat2)/2

if ARGV[0] == "percent"
  puts(bat.to_s + "%")
  return
elsif ARGV[0] == "icon"
  if bat < 13
    puts('')
  elsif bat < 38
    puts('')
  elsif bat < 63
    puts('')
  elsif bat < 83
    puts('')
  else
    puts('')
  end
end

