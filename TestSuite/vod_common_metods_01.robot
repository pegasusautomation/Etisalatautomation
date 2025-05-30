*** Settings ***
Library    Process
Library    AppiumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    DateTime
Variables    C:/D_Drive/Etisalatautomation/Variables/Generic/Home.yaml
Variables    C:/D_Drive/Etisalatautomation/Variables/Generic/OnDemand.yaml
Resource    C:/D_Drive/Etisalatautomation/Lib/Robot/ANDROID_TAB/ANDROID_TAB_Functions.robot
Resource    C:/D_Drive/Etisalatautomation/Lib/Robot/ANDROID_TAB/ANDROID_TABLET_HOME_PAGE.robot

*** Variables ***
${ONDEMAND_TITLE}    ON DEMAND
${ON_DEMAND}         xpath=//android.widget.TextView[@text="ON DEMAND"]
${FIRST_TILE}       //android.widget.GridView/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.widget.ImageView
${LIVE_CONTENT}      xpath=//android.widget.TextView[contains(@text, 'Live') or contains(@text, 'Catch Up')]
${MOVIE_TITLE}       xpath=//android.widget.TextView[contains(@text, 'Movie') or contains(@text, 'Series')]
${BACK_BUTTON}       id=back_button
${SCROLL}           xpath=//android.widget.ScrollView

*** Keywords ***
Navigate To On-Demand Tab
    Sleep    2s
    Click Element    ${ON_DEMAND}
    Sleep    3s
#    Wait Until Page Contains Element    ${ONDEMAND_TITLE}    timeout=15s
#    Click And Verify Tile

Click And Verify Tile
    Click Element    ${FIRST_TILE}
    Handle Pin Entry If Required
    Sleep   2s
    Verify Movie Details

Click And Verify Multiple Tiles
    FOR    ${INDEX}    IN RANGE    3
        Click And Verify Tile
    END

Verify Movie Details
   ${is_present}    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[contains(@text, 'Movie') or contains(@text, 'Series')]
    Run Keyword If    ${is_present}    Log    "Movie/Series element found!"
    Go Back
    Scroll Down

Scroll Down
    Swipes    500    1200    500    600

   
Confirm tile
    Navigate To On-Demand Tab
    Sleep    2s
    Click Element    //android.widget.ScrollView//android.widget.FrameLayout[3]//android.widget.FrameLayout[1]//android.widget.FrameLayout
    Click Element    ${FIRST_TILE}
    Sleep    5s
    ${selected_category}    Get Text    //android.widget.ScrollView//android.widget.FrameLayout[3]//android.widget.FrameLayout[1]//android.widget.FrameLayout//android.widget.TextView
    Log To Console     Selected VOD Category: ${selected_category}
    Click Element    ${FIRST_TILE}
    Handle Pin Entry If Required
    Wait Until Element Is Visible   xpath=(//android.widget.ScrollView//android.widget.LinearLayout//android.widget.FrameLayout[2]//android.widget.LinearLayout)[1]
    ${Category}=     Extract Title And Channel    ${INDEX1}    ${INDEX2}
    Log To Console    ${Category}
#    if ${Category} == ${selected_category}:
#        Log To Console    selected category is playable
    
    Sleep    3s

*** Test Cases ***
# Verify VOD Category Selection
#     [Documentation]    Verify VOD Category
#     [Tags]    VOD
#     [Setup]    TEST SETUP GENERIC ANDROID PHONE
#     Navigate To Admin Profile
#     Navigate To VOD
#     Select Genre    ${GENRE_CATEGORY_COMEDY}
#     Sleep    2s
#     Click Element    ${FIRST_TILE}
#     ${isTrue}=    Verify Genre Selection    ${GENRE_CATEGORY_MUSIC}
#     Should Be True    ${isTrue}    Genre selection verification failed

501_Verify Live And Catch Up Content Presence Under On-Demand Tab
    [Documentation]    Verify that Live and Catchup genres are not listed under the VOD section
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE

    # Navigate to the admin profile and open the VOD section
    Navigate To Admin Profile
    Navigate To VOD

    # Select the 'Comedy' genre to simulate genre selection under VOD
    Select Genre    ${GENRE_CATEGORY_COMEDY}
    Sleep    2s

    # Tap on the first VOD tile (assumed to be present)
    Click Element    ${FIRST_TILE}

    # Verify that 'Live' genre is NOT listed under VOD
    ${isLiveContent}=    Verify Genre Selection    ${GENRE_CATEGORY_LIVE}
    ${isLiveContent_Str}=    Convert To String    ${isLiveContent}
    Should Be Equal    ${isLiveContent_Str}    False    Live content is present under VOD

    # Verify that 'Catchup' genre is also NOT listed under VOD
    ${iscatchupContent}=    Verify Genre Selection    ${GENRE_CATEGORY_CATCHUP}
    ${isCatchupContent_Str}=    Convert To String    ${iscatchupContent}
    Should Be Equal    ${isCatchupContent_Str}    False    Catchup content is present under VOD

# 502_Verify Playback Under VOD Feed
#     [Documentation]    Verify that Live and Catchup genres are not listed under the VOD section
#     [Tags]    VOD
#     [Setup]    TEST SETUP GENERIC ANDROID PHONE

#     # Navigate to the admin profile and open the VOD section
#     Navigate To Admin Profile
#     Navigate To VOD
#     Play VOD Content
#     Verify Playback During Playing

503_Verify Playback Under VOD Feed
    [Documentation]    Verify that Live and Catchup genres are not listed under the VOD section after searching for content
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To VOD
    Click Element    //android.widget.FrameLayout[2]/android.widget.ImageView
    Wait Until Page Contains    SEARCH    timeout=${TIMEOUT}
    Log To Console    ✅ Search screen is visible
    Click Element    xpath=//android.widget.EditText[@text="Search all content"]
    Input Text    xpath=//android.widget.EditText[@text="Search all content"]    Peter rabbit
    Sleep         1s
    Press Keycode    66    # Try Enter
    Sleep         s
    ${is_title_found}=    Verify Selected VOD Title    Peter Rabbit
    Should Be True    ${is_title_found}    "Peter Rabbit" is not found in the list
    

507_Verify Navigate To VOD Section From Playback
    [Documentation]    Verify that Live and Catchup genres are not listed under the VOD section
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE

    # Navigate to the admin profile and open the VOD section
    Navigate To Admin Profile
    Navigate To VOD
    Play VOD Content
    Verify Playback During Playing
    Navigate To VOD Page From Playback







