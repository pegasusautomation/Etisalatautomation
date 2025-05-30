*** Settings ***
Library    Process
Library    BuiltIn
Library    OperatingSystem
Library    Collections
Library    String
Library    AppiumLibrary
Resource    C:/D_Drive/Etisalat_Android/Etisalat_Android/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot
Variables    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/variables.yaml
Resource    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/keywords.robot


*** Variables ***
&{TAP_COORDINATES}
...    1080x2400_480=210,998
...    1080x2340_480=1012,148
...    1080x2412_480=220,998
...    1080x2400_420=235,998
@{UNWANTED_KEYWORDS}    HOME    TV GUIDE    LIVE TV    ON DEMAND    UNLIMITED    STORE    MY LIST    ASSIST    REMINDER    RECORD    PLOT    AUDIO    SUBTITLES    PROGRAM DETAILS    Information    Similar

*** Keywords ***
Navigate To GUIDE
    LAUNCH TV BY E APP IN ANDROID PHONE
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@class='android.widget.ImageView']    10s
    Click Element    xpath=//android.widget.ImageView[@class='android.widget.ImageView']
    sleep    3s
    Click Element    xpath=//*[ @class='android.widget.TextView' and contains(@text,'TV GUIDE')]
    sleep    5s

Get All Visible Text
    ${elements}=    Get Webelements    //android.widget.TextView
    @{texts}=    Create List
    FOR    ${element}    IN    @{elements}
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${visible}
            ${text}=    Get Text    ${element}
            Append To List    ${texts}    ${text}
        END
    END

Get Program Details Of LIVE TV
    ${texts}=    Get All Visible Text
    ${cleaned}=    Evaluate    [x for x in ${texts} if x not in ${UNWANTED_KEYWORDS}]
    Log To Console    Filtered=${cleaned}

    # Assuming the last 2 are title and channel
    ${title}=    Get From List    ${cleaned}    1
    ${channel}=  Get From List    ${cleaned}    2
    ${titles1}=  Create List    ${title}    ${channel}
    Log To Console    Final Titles=${titles1}
Tap on FAVORITE option
    sleep    5s
    Tap Based On Action And Resolution    add_favorite
    # Run Process    adb    shell    input    tap    1012    148    shell=True
    Sleep    3s
    Click Element    xpath=//android.widget.TextView[@text="FAVORITE"]
    sleep    20s
Verify Display Of UNFAVORITE Option
    sleep    5s
    ${Unfav}=     Get Text    xpath=//android.widget.TextView[@text="UNFAVORITE"]
    Log To Console    ${Unfav}
    Should Be Equal    ${Unfav}    UNFAVORITE
    Sleep    3s
Tap on HOME option
    Sleep    3s
    Click Element    xpath=(//android.widget.TextView[@text="HOME"])[2]
    Sleep        3s

Navigate To FAVORITES
    Sleep   2s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_FAVORITES}
    Wait Until Element Is Visible    ${FAVORITE_CONTENT}
    Page Should Contain Text    FAVORITES
    Click Element    ${FAVORITE_CONTENT}
    Wait Until Page Contains    PROGRAM DETAILS
    Sleep    2s
    

*** Test Cases ***
Tap To Pause And Verify Paused State
    Navigate To GUIDE
    # Get Program Details Of LIVE TV
    Tap on FAVORITE option
    Verify Display Of UNFAVORITE Option
    Tap on HOME option
    Navigate To FAVORITES