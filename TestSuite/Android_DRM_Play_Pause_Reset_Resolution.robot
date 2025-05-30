*** Settings ***
Library    Process
Library    BuiltIn
Library    OperatingSystem
Library    Collections
Library    String
Library    AppiumLibrary
Resource    C:/D_Drive/Etisalatautomation/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot

*** Variables ***
&{TAP_COORDINATES}    
...    1080x2400_480=210,998
...    1080x2340_480=1971,54
...    1080x2412_480=220,998
...    1080x2400_420=235,998

*** Keywords ***
Tap Play Pause Based On Resolution And DPI
    # # Get screen resolution
    # ${res_output}=    Run Process    adb    shell    wm size    shell=True
    # ${res_stdout}=    Set Variable    ${res_output.stdout}
    # ${resolution}=    Evaluate    '${res_stdout}'.strip().split(":")[1].strip()
    # Log To Console    Resolution: ${resolution}

    # # Get screen DPI (physical density only)
    # ${dpi_output}=    Run Process    adb    shell    wm density    shell=True
    # ${dpi_stdout}=    Set Variable    ${dpi_output.stdout}
    # ${dpi_lines}=     Split To Lines    ${dpi_stdout}

    # ${dpi}=    Set Variable    NONE
    # FOR    ${line}    IN    @{dpi_lines}
    #     Run Keyword If    'Physical density' in '${line}'    Set Test Variable    ${dpi}    ${line.split(":")[1].strip()}
    # END

    # Log To Console    DPI: ${dpi}


    # # Combine to form key
    # ${key}=    Set Variable    ${resolution}_${dpi}
    # Log To Console    Using resolution+dpi key: ${key}

    # # Get coordinates from dictionary
    # ${coords}=    Get From Dictionary    ${TAP_COORDINATES}    ${key}
    # Run Keyword If    '${coords}' == ''    Fail    No tap coordinates mapped for key: ${key}

    # ${x}=    Evaluate    '${coords}'.split(",")[0]
    # ${y}=    Evaluate    '${coords}'.split(",")[1]
    # Log To Console    Tapping at coordinates: ${x}, ${y}
    # Run Process    adb    shell    input    tap    ${x}    ${y}    shell=True
    Sleep    3s
    Click Element    xpath=//android.widget.TextView[@text="FAVORITE"]
 
*** Test Cases ***
Tap To Pause And Verify Paused State
    Run Process    adb    logcat    -c
    Sleep    1s
    # Run Process    adb    shell    input    tap    540    720    shell=True
    Sleep    2s
    Tap Play Pause Based On Resolution And DPI
    Sleep    2s

    ${output}=    Run Process    adb    logcat    -d    |    findstr    player_aha    shell=True
    ${logs}=      Set Variable    ${output.stdout}
    Log    ${logs}

    Should Contain    ${logs}    onInformation:1100 i1=0
    Log    ✅ Video is paused