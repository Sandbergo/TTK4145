#!/bin/bash
epmd -daemon # fix erlang issue

# start server
#pkill ElevatorServer # kill last instance of server
#cd ~/Documents/gr25/TTK4145
#gnome-terminal -x ~/.cargo/bin/ElevatorServer & disown 


# compile
#mix compile

# run boy ruuuuuuuuuuuuuun 
#while ! iex -S mix run -e NetworkHandler.test
#do 
  #pkill ElevatorServer # kill last instance of server
  #cd ~/Documents/gr25/TTK4145
  #gnome-terminal -x ~/.cargo/bin/ElevatorServer & disown 
  #sleep 2
  #echo "Restartin!"
#done


iex -S mix run -e Overseer.main