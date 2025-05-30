*** Settings ***
Library    AppiumLibrary
Library    Process

*** Test Cases ***
Play DRM Video And Validate
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=Android Emulator    appPackage=com.example.app    appActivity=.MainActivity
    Click Element    id=com.example.app:id/play_button
    Sleep    10s
    ${logs}=    Run Process    adb    logcat    -d
    Should Contain    ${logs.stdout}    Video is playing
