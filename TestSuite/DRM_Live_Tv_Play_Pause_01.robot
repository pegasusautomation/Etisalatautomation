*** Settings ***
Library    Process
Library    BuiltIn
Library    OperatingSystem
Library    Collections
Library    String
Resource    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/keywords.robot

*** Test Cases ***
Tap To Pause And Verify Paused State
    Run Process    adb    logcat    -c
    Sleep    1s
    Run Process    adb    shell    input    tap    540    720    shell=True
    Sleep    2s
    Tap Based On Action And Resolution    maximize_minimize
    Sleep    2s

    ${output}=    Run Process    adb    logcat    -d    |    findstr    player_aha    shell=True
    ${logs}=      Set Variable    ${output.stdout}
    Log    ${logs}

    Should Contain    ${logs}    onInformation:1100 i1=0
    Log    ✅ Video is paused