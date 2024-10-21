# Setup Instructions on Linux (updated September 11th, 2024)

### Installing Android SDK without Android Studio

1. Navigate to https://developer.android.com/studio#command-tools
2. Download the latest android sdk commandline-tools for linux using link at bottom of page
3. unzip downloaded file to extract contents revealing 'cmdline-tools' directory
4. create a directory called 'latest' inside 'cmdline-tools' and place all other items into 'latest'
5. move 'cmdline-tools' to home folder and create the following directory structure:
    - ~/android-sdk/cmdline-tools/latest/*
6. navigate to ~/android-sdk/cmdline-tools/latest/bin and exectue ./sdkmanager 'packagename' to install at least the following for flutter development (will need at least openjdk-17-jdk to exectue sdkmanager):
    - 'platform-tools'
    - 'build-tools;`<version`>' (execute ./sdkmanager --list to view all available package versions)
    - 'platforms;`<version`>' (execute ./sdkmanager --list to view all available package versions)
    - 'emulator' (if using android emulator for testing, if using physical device do not need this)
7. update ~/.bashrc file with the following lines:
    - export ANDROID_HOME=~/android-sdk
    - export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
    - export PATH=$PATH:$ANDROID_HOME/build-tools/`version`
    - export PATH=$PATH:$ANDROID_HOME/platform-tools/

### Installing Flutter and Dart SDK

1. Install Flutter and Dart extensions on vscode
2. enter ```ctrl+shift+P``` to open command palette
3. type ```flutter```
4. select ```new project```
5. when prompted, download and install the flutter SDK which includes the Dart SDK
6. add following line to ~/.bashrc:
    - ```export PATH=$PATH:/path/to/flutter/bin```
7. open a terminal and enter ```source ~/.bashrc```
8. enter ```flutter doctor``` and ensure android development is marked with a green check, if not, follow prompts and accept lisence agreements