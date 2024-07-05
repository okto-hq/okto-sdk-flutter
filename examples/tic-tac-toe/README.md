## Tic Tac Toe game
### powered by okto.

### Requirements
    - Flutter SDK
    - Okto Keys

### Running the app
    - `flutter pub get`
    - `flutter run`

### Setup :
    This game uses google auth of okto : 
    follow this guide to setup google sign in on google cloud console - https://sdk-docs.okto.tech/guide/google-authentication-setup

    1. Obtain the web client id, and put it in the `android/app/src/main/res/values/strings.xml`
    2. Create A new android client id using the SHA-1 Key of this application.

### Uses :
    - Authenticated user is Player 'X'
    - You can call any function when the Player 'X' wins, for example, gifting a NFT whenever Player 'X' Wins..
    - Go to `lib/core/game.dart`
    - Edit the `checkForWinners()` function, according to your need.
    - That's it.
    
    
    
    
![okto ss](https://github.com/okto-hq/okto-sdk-flutter/assets/71646773/3dc31de5-7454-4cc4-b6e8-2244acaf4418)
