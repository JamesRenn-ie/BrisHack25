# BrisHack25
## Eco bike project
Team members: James Rennie, Austin Doubleday, Erfan Fazal, Ezen Tan, Ammar Rosnan
### The project: 
This project was created to compete in the BrisHack25 hackathon with the theme "ECO". The idea is a bike rental scheme that rewards you with free bike rides for picking up litter. 

The three sections of the app are:
1) a webcam that can detect litter in realtime
2) a server to process the detection and notify the app
3) an App that works as the bike rental platform and detect earned points.
4) A raspberry pi mounted on the bike with and LED to display when it's "locked" or "unlocked" (this section was never properly completed due to running out of time)
   
We used the [RoboFlow API](https://universe.roboflow.com/) with a pretrained model to do the litter detection from an RTSP webcam on the bike. A flask app was used for the backend and then a flutter frontend was developed to run as an app on a phone.

## Try the project yourself
To load the project clone repository and then checkout the mergedBranch branch.
You need some sort of RTSP streaming device (you can get an app on the playstore called IP WEBCAM) and then you need to put the IP of the webcam into the EcoBike/back_end/vidAI.py file and the IP of the machine you want to act as the server into EcoBike/lib/backend_bloc.dart. Make sure all devices are on the same wifi network, and then run the flaskApp.py on the computer and main.dart on your phone and give it a try!
