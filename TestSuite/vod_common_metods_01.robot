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

*** Settings ***
Library    AppiumLibrary
Library    BuiltIn

*** Test Cases ***

*** Test Cases ***
501_Verify Live And Catch Up Content Presence Under On-Demand Tab
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Select Genre    ${GENRE_CATEGORY_COMEDY}
    Wait For Genre Content To Load
    Click Element    ${FIRST_TILE}
    ${isLiveContent}=    Verify Genre Selection    ${GENRE_CATEGORY_LIVE}
    Should Be True    '${isLiveContent}' == 'False'    Live content is present under VOD
    ${isCatchupContent}=    Verify Genre Selection    ${GENRE_CATEGORY_CATCHUP}
    Should Be True    '${isCatchupContent}' == 'False'    Catchup content is present under VOD
    [Teardown]    Close TvBY_e& Application

502_Verify Playback Under VOD Feed
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Play VOD Content
    Verify Playback During Playing
    [Teardown]    Close TvBY_e& Application

503_Verify Playback After Search
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Wait Until Page Contains    SEARCH    timeout=${TIMEOUT}
    Click Element    xpath=//android.widget.EditText[@text="Search all content"]
    Input Text    xpath=//android.widget.EditText[@text="Search all content"]    Peter rabbit
    Press Keycode    66
    ${isTitleFound}=    Verify Selected VOD Title    ${VOD_TITLE}
    Should Be True    ${isTitleFound}    "Peter Rabbit" is not found in the list
    [Teardown]    Close TvBY_e& Application

507_Verify Navigate To VOD Section From Playback
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Play VOD Content
    Verify Playback During Playing
    Navigate To VOD Page From Playback
    [Teardown]    Close TvBY_e& Application

508_Verify Subtitles on VOD Playback
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Play VOD Content
    Verify Playback During Playing
    Get Seekbar On Player
    Select Subtitle Language As English
    Verify Subtitle Display on Player
    Select Subtitle Language As No Subtitle
    Verify Subtitle Invisibility on Player
    [Teardown]    Close TvBY_e& Application

513_Verify Continue Watching VOD Playback
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Click Back Button
    Move To Feed    CONTINUE WATCHING
    Select Continue Watching Content To Play
    ${isTitleFound}=    Verify Selected VOD Title    Peter Rabbit
    Should Be True    ${isTitleFound}    "Peter Rabbit" is not found in the list
    Play VOD Content
    Verify Playback During Playing
    [Teardown]    Close TvBY_e& Application

515_Verify Live And Catch Up Absence Under Different Genre
    [Tags]    VOD
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    Navigate To Admin Profile
    Navigate To Feed   ${ON_DEMAND}
    Select Genre    ${GENRE_CATEGORY_ADVENTURE}
    Wait For Genre Content To Load
    Click Element    ${FIRST_TILE}
    ${isTrue}=    Verify Genre Selection    ${GENRE_CATEGORY_ADVENTURE}
    Should Be True    ${isTrue}    Genre selection verification failed
    Play VOD Content
    Verify Playback During Playing
    [Teardown]    Close TvBY_e& Application