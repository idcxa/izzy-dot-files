#!/usr/bin/env ruby
# a smooth logarithmic brightness script using brightnessctl

v = ARGV[0]

s = (`brightnessctl get`.to_i / 3).ceil

p s

if v == 'up'
  system('brightnessctl set +1')
  s.times do
    sleep(0.001)
    system('brightnessctl set +1')
  end
end

if v == 'down'
  system('brightnessctl set 1-')
  s.times do
    sleep(0.001)
    system('brightnessctl set 1-')
  end
end
