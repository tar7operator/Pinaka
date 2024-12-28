Installation
Clone this repository and then get into the folder. In the terminal write the following command depending on your OS:

Windows
python -m venv .venv
.\.venv\Scripts\activate 
Linux
python -m venv .venv
source .venv/bin/activate
Then install the requirements with (no matter your os):

pip install -r .\requirements.txt
After this the program should be good to go, to initialize the program type:

python .\launcher.py
how to use
Just select the port and the baudrate and connect it !

Custom Graphs
Modifying the graphs is really easy, go to ./edvs/modules/managers/graph_manager.py, first create a new object with the class of the graph you want to use in the set_graph() function, also you need to add it to a layout, you can use the existing ones as example. Then you need to add the update function of your graph with the respective data into the update() function. For modifying the graph objects go to ./edvs/modules/utility/graph_types.py and have fun!

Terminal Commands:
Type "/help" to show all the command in the terminal line, if the message start with the command prefix (you can change it in the config) the data is not sent, but interpreted as a command.

Dummy:
"/dummy.on" for starting the simulation
"/dummy.off" you can guess
"/dummy.time (time)" change the update time for the data to appear, time need to be a float and in seconds, 0.5 for half a second 1.0 for a second.
Unplug Mode:
Unplug it !!

Saves
The record button saves all the data comming from the serial port to a csv file, you can open the folder in config tab or by a typing "/saves" in the terminal.