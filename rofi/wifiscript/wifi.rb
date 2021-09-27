#!/usr/bin/env ruby
# dir = `cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
# font = "Fira Code 12"
theme = '$HOME/.config/rofi/wifi/style.rasi'

max_lines = 15


wifi = `nmcli radio wifi`
# p `echo $(#{wifi})`

s =
  `tail -n +2 <<< $(nmcli --fields SSID,BARS,SECURITY,RATE,BSSID device wifi list)`.chomp

#
#con = []
#c.each_line do |line|
#  v = line.gsub(/\s+/m, ' ').strip.split('▂')
#  con.push(v)
#end

lines = "Wifi: #{wifi}"
count = 0

def connection?(ssid)
  cmd = `nmcli con show '#{ssid}'`
  cmda = cmd.gsub(/\s+/m, ' ').strip.split(' ')
  return true if cmda[0] == 'connection.id:'

  false
end

# b = a.gsub(/\s+/m, ' ').strip.split('*')[1]

def in_use?(ssid)
  a = `tail -n +2 <<< $(nmcli --fields IN-USE,SSID device wifi list)`.chomp
  active = ''
  a.each_line do |line|
    b = line.gsub(/\s+/m, ' ').strip.split('* ')
    if b[0] == ''
      active = b[1]
    end
  end
  return true if ssid == active

  false
end

s.each_line do |line|
  v = line.gsub(/\s+/m, ' ').strip.split('▂')
  # u = line.gsub(/\s+/m, ' ').strip.split(' ')
  p = v[1].gsub(/\s+/m, ' ').strip.split(' ')

  if in_use?(v[0].chomp(' '))
    line = "*   #{line}"
  elsif p[1] == '--'
    line = "u   #{line}"
  elsif connection?(v[0].chomp(' '))
    line = "   #{line}"
  else
    line = "   #{line}"
  end
  lines = lines += line
  count += 1
end

numlines = `tail -n +2 <<< $(nmcli --fields SSID,BARS,SECURITY,RATE,BSSID device wifi list) | wc -l`.to_i
numlines = max_lines if numlines > max_lines

command = "'#{lines}' | rofi -dmenu -p 'SSID' -theme #{theme} -lines #{numlines}"
# command = "rofi -dmenu -e '%s' " % [s]

out = `echo #{command}`
v = out.gsub(/\s+/m, ' ').strip.split(' ')
u = out.gsub(/\s+/m, ' ').split('▂')
v = u[0].gsub(/\s+/m, ' ').split(' ')
p v
v = v.drop(1)
p v
ssid = ''
v.each do |t|
  ssid += "#{t} "
end
p ssid
ssid = ssid.chomp(' ')

def toggle_wifi(state)
  if state == 'enabled'
    system('nmcli radio wifi off')
  else
    system('nmcli radio wifi on')
  end
end

def password_enter(ssid, password)
  # system("nmcli dev wifi con %s " % [$v[0]] +"password %s" % [password])
  cmd = "nmcli dev wifi con #{ssid} password #{password}"
  system(cmd)
end

case ssid
when '*'
  # deactivate connection
when nil
  return
when 'enabled' || 'disabled'
  toggle_wifi(v[2])
else
  cmd = `nmcli dev wifi con '#{ssid}'`
  p cmd
  cmda = cmd.gsub(/\s+/m, ' ').strip.split(' ')
  return if cmda[0] != 'Error:'

  cmd = "rofi -dmenu -p 'Enter Password:' -theme #{theme} -lines 0"
  loop do
    pass = `#{cmd}`
    break if password_enter(v[0], pass) == true || pass == ''

    cmd = "rofi -dmenu -p 'Enter Password:' -mesg 'Failed' -theme #{theme} -lines 0"
    p cmd
  end
end
