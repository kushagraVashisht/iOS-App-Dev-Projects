# iOS-App-Dev-Projects

## Summary for the projects

This project directory is made just for fun and to improve my programming level in iOS App Development. Some of the projects are my personal projects, some are sub-functionality programs which will be used inside main programs. The remaining projects are practice questions given as homework for the iOS-App-Dev course done on Udemy.
The deliverables for the projects are individual iOS applications. 
The projects use Swift, Obj-C and a variety of application-level dependency managers such as cocopods and carthage!
Trello, Zenhub and Jira(few projects) were used for Agile project management
Git Kraken was used as a Git GUI client for the projects

## Project Descriptions

### Animations: 
**Description**: Trying out animations for loading screen and gesture recognizers. Used libraries from Cocoa-pods and https://github.com/onmyway133/fantastic-ios-animation/blob/master/Animation/framework.md<br/>
**Languages used**: Swift and Obj-C

### Autolayout Practice with Dicee-iOS-11: 
**Description**: Learning to use Autoloayout for the projects to allow the projects to be runnable on all the iOS devices<br/>
**Languages used**: Swift

### Destini iOS 11
**Description**: Works like magic ball (I guess?). Works like a storyline with different outcomes<br/>
**Languages used**: Swift

### Dicee
**Description**: Rolling dice application for iOS with sprites resembling casino table. Uses cocoapods for producing animations to produce the rolling effect<br/>
**Languages used**: Swift, Obj-c

### I AM RICH
**Description**: Replicating the $1000 app on the app store. (P.s, it was the biggest scam of that century)<br/>
**Languages used**: Swift

### I AM POOR
**Description**: You bought the $1000 app, now you're poor (jk). Learning to design our own UI elements for the storyboard and learning to make the app-icons for the application as well as the app-store. Used heavy animations for the project<br/>
**Languages used**: Swift







The deliverable for this project will be a smartphone application, targeted at android users. The application will allow cared-for users to navigate outside independently, using the map, or with the help of a carer.

The carer will assist through a variety of functions including voice and video calls, text chat, screen sharing and location services. This will allow the carer to provide direction and guidance to the elderly user. Additionally, the carer will be able to customize the cared-for individuals calendar which will automatically notify the user of such appointments so that they can complete some tasks independently.

The cared-for individual will be able to add friends or carers, and communicate with them via text, voice or video call.

They will also be able to customize their own calendars, allowing them to be notified of events and provided directions to these occasions easily and efficiently.

APIs
This project is built using:

Firebase
Authentication
Friends lists
Messages
Calendar
Mapbox
Turn-by-turn Navigation
Sinch
Voice and Video calls
Google API's
Location Search
Build Instructions
Pull from the master branch and open the project in Android Studio.
Plug in your phone, or start it on an emulator by pressing the play button.
Test Instructions
Test Modules are contained within:

./app/src/test/java/com/example/ritusharma/itproject/
Open any module to run it :D

We attempted to write tests for Activities and Firebase methods, but after several hours of making no real progress (with issues importing PowerMockito into Android Studio) we decided it wasn't worth losing sleep over.

App Flow
The MainActivity is the Home Screen for the user. It displays the map (with the User's Location) and a search bar for navigation. It also contains a Drawer for navigating to other features.
If the User isn't logged in when they open the app, the app will open the PhoneAuthActivity to ask the user to login to Firebase.
Once a user has logged in or signed up, the EditUser activity will open. It allows the user to enter their details like Name, UserName and Caring Status, which is then written to firebase when the "next" button is pressed, which also navigates back to the MainActivity.
The Drawer on MainActivity contains links to the other Activities within the app, like Calendar, Friends, MyDetails and LogOut.
The Calendar activity allows users to add events to their personal calendar and view them in a RecyclerView, sorted by the selected Date.
The FriendListActivity allows the user to see all the friends they currently have in their list, sorted by the date they added them. (Ideally, the carer will be the first friend they add so they'll always be on top of the list)
The AddFriendActivity allows the user to add a friend by their Phone Number. The friend must add them back via their phone number to solidify the friend link, so they will likely have communicated in some other context before using the app together.
The ChatRoomActivity is opened when a User clicks on one of the friends names. It displays the messages between the two users, and allows the user to send new messages. There are links to open a Sinch Video or Voice Call on the top panel.
The CallingScreen link allows the user to return to an open Sinch call if one is open, otherwise it does nothing.
Open Calls show the other user's name, a timer for the call, and the video if a video call is being placed.
The Logout button logs the user out of firebase and Sinch and Opens the PhoneAuthActivity again.
