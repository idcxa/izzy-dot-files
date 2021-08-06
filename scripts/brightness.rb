#!/usr/bin/env ruby
v = ARGV[0]

s = ((`brightnessctl get`.to_i)/10).ceil

for i in 1..s do
  if v == "up"
    system("brightnessctl set +1")
  elsif v == "down"
    system("brightnessctl set 1-")
  end
end

