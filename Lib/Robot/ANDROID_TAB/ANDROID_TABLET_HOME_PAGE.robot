*** Settings ***
Library         Process
Library    AppiumLibrary     run_on_failure=No Operation
Library    OperatingSystem
Library         String
Library    Collections
Library         DateTime
Resource   C:/D_Drive/Etisalatautomation/Lib/Robot/ANDROID_TAB/ANDROID_TAB_Functions.robot
Variables    C:/D_Drive/Etisalatautomation//Variables/Generic/Home.yaml
Variables    C:/D_Drive/Etisalatautomation/Variables/Generic/OnDemand.yaml
Resource    C:/D_Drive/Etisalatautomation/TestSuite/keywords.robot

*** Keywords ***
Scroll Back To Top

    [Documentation]    Scroll up to return to the top of the home page.

    FOR    ${i}    IN RANGE    5
        ${start_x}=    Set Variable    540
        ${start_y}=    Set Variable    300
        ${end_x}=      Set Variable    540
        ${end_y}=      Set Variable    1800
        Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    1000
        Sleep    1s
    END
    Log To Console     Scrolled back to top

    
Handling Pop Up
    Sleep    3s
    ${popup_present}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CANCEL_BUTTON}    timeout=${TIMEOUT}
    Run Keyword If    ${popup_present}
    ...    Click Element    ${CANCEL_BUTTON}
    Log To Console    Pop-up handled

Handle Pin Entry If Required
        Wait Until Page Contains Element    ${PIN_CODE}    timeout=${TIMEOUT}
    Element Should Be Visible   ${PIN_CODE}
    Click Element    ${PIN_CODE}
    Input Text    ${PIN_CODE}    ${ADMIN_PASSWORD}
    Click Element    ${OK_BUTTON}

Navigate To Admin Profile
    # Launch TV By E App In Android Phone
    Sleep    2s
    ${profiles}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROFILE_TEXT}
    Run Keyword If    '${profiles}' == 'True'    Log To Console    Profile page is visible
    Log To Console    ${profiles}
    IF    ${profiles} == True
        Sleep    5s
        Click Text    ${ADMIN_PROFILE}
        Sleep    5s
        Log    ${ADMIN_PROFILE} Selected successfully
        ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PIN_CODE}    timeout=${TIMEOUT}
        Run Keyword If    '${is_present}' == 'True'    Input Text    ${PIN_CODE}    ${ADMIN_PASSWORD}
        Run Keyword If    '${is_present}' == 'True'    Click Element    ${OK_BUTTON}
        Log To Console    admin pin is entered
        Sleep    2s
        Handling Pop Up
    ELSE
        Log    Profile page is not visible
    END

Navigate To User Profile
    ${profiles}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROFILE_TEXT}
    Run Keyword If    '${profiles}' == 'True'    Log To Console    Profile page is visible
    Log To Console    ${profiles}
    IF    ${profiles} == True
        Sleep    5s
        Click Element    ${ADMIN1_PROFILE}
        Log    profile selected successfully
        ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PIN_CODE}    timeout=${TIMEOUT}
        Run Keyword If    '${is_present}' == 'True'    Input Text    ${PIN_CODE}    ${ADMIN_PASSWORD}
        Run Keyword If    '${is_present}' == 'True'    Click Element    ${OK_BUTTON}
        Log To Console    admin pin is entered
        Sleep    5s
#        Handle Pin Entry If Required
#        Handling Pop Up
    ELSE
        Log    Profile page is not visible
    END

Home Page Loading
    Sleep    10s
    Wait Until Element Is Visible    ${HOME_TEXT}    timeout=${TIMEOUT}
    Element Should Be Visible    ${HOME_TEXT}
    Wait Until Element Is Visible    ${LIVE_TV_TEXT}
    Element Should Be Visible    ${LIVE_TV_TEXT}

Epg Navigation
#    Sleep    5s
#    Wait Until r5Element Is Visible    ${HOME_TEXT}    timeout=${TIMEOUT}
    Click Element    ${MENU_BAR}
    Click Element    ${TV_GUIDE}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${ALL_CHANNEL}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${TODAY}
    Log To Console    Navigated to EPG
    Click Element    ${MENU_BAR}
    Click Text    HOME

Close TvBY_e& Application
    [Documentation]    Close the Tv by e& app
    Terminate Application    com.huawei.phone.elife
    Sleep    2s

Navigate To VOD
    [Documentation]    Navigate to the Electronic Program Guide (EPG) and verify the displayed program information.
    Sleep    5s
#    Wait Until r5Element Is Visible    ${HOME_TEXT}    timeout=${TIMEOUT}
    Click Element    ${MENU_BAR}
    Click Element    ${ON_DEMAND}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${ON_DEMAND}
    Log To Console    Navigated to On Demand

Select Genre
    [Arguments]    ${genre}
    # Wait to ensure the UI is stable before interaction
    Sleep    5s
    # Tap on the Genre dropdown to display the genre list
    Click Element    xpath=${GENRE_DROPDOWN_XPATH}
    Sleep    3s
    # Dynamically construct the XPath for the desired genre option
    ${genre_xpath}=    Set Variable    xpath=//android.widget.TextView[@text='${genre}']
    # Select the given genre from the dropdown
    Click Element    ${genre_xpath}
    Sleep    3s


Verify Genre Selection
    [Arguments]    ${expected_genre}
    # Short wait to allow elements to load after UI interaction
    Sleep    2s
    # Construct XPath for the expected genre
    ${genre_xpath}=    Set Variable    //android.widget.TextView[@text="${expected_genre}"]
    # Check whether the expected genre element is present on the page
    ${is_present}=     Run Keyword And Return Status    Page Should Contain Element    xpath=${genre_xpath}
    # Log the result clearly based on presence status
    Run Keyword If    '${is_present}' == 'True'
    ...    Log    ✅ ${expected_genre} genre is listed
    ...  ELSE
    ...    Log    ❌ ${expected_genre} genre is NOT listed
    # Return the boolean result to the caller
    [Return]    ${is_present}

Play VOD Content
    [Documentation]    Play the selected VOD content and verify the playback.
    Sleep    3s
    Tap Based On Action And Resolution    select_vod
    Run Process    adb    logcat    -c
    Sleep    2s
    Tap Based On Action And Resolution    play_vod

Verify Playback During Playing
    Sleep    15s
    ${output}=    Run Process    adb    logcat    -d    |    findstr    player_aha    shell=True
    ${logs}=      Set Variable    ${output.stdout}
    Log    ${logs}
    Sleep    3s
    Should Contain    ${logs}    onInformation:1100 i1=1
    Log    ✅ Video is playing

Verify Playback During Pause
    ${output}=    Run Process    adb    logcat    -d    |    findstr    player_aha    shell=True
    ${logs}=      Set Variable    ${output.stdout}
    Log    ${logs}

    Should Contain    ${logs}    onInformation:1100 i1=0
    Log    ✅ Video is playing

Get Seekbar On Player
    Sleep    5s
    Tap Based On Action And Resolution    tap_centre_of_player

Select Subtitle Language As English
    Tap Based On Action And Resolution    maximize_player
    Sleep    5s
    Get Seekbar On Player
    Sleep    2s
    Tap Based On Action And Resolution    choose_subtitle_language
    Sleep    2s
    Tap Based On Action And Resolution    select_english_subtitle

Select Subtitle Language As No Subtitle
    Sleep    5s
    Get Seekbar On Player
    Sleep    2s
    Tap Based On Action And Resolution    choose_subtitle_language
    Sleep    2s
    Tap Based On Action And Resolution    no_subtitle

Verify Subtitle Display on Player
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    xpath=//android.view.View[@resource-id="subtitles"]

Verify Subtitle Invisibility on Player 
    Sleep    10s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//android.view.View[@resource-id="subtitles"]
    Run Keyword If    '${is_visible}' == 'False'
    ...    Log To Console    ✅ Subtitle is NOT visible on the player
    ...  ELSE
    ...    Log To Console    ❌ Subtitle is still visible on the player
    

Click Back Button
    Sleep    2s
    Tap Based On Action And Resolution    back_button

Navigate To VOD Page From Playback
    [Documentation]    Navigate back to the VOD page from the playback screen.
    Sleep    2s
    Click Back Button
    Run Keyword And Continue On Failure    Element Should Be Visible    ${ON_DEMAND}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${VOD_LANGUAGE_TEXT}
    Log To Console    Navigated to On Demand

Verify Selected VOD Title
    [Arguments]    ${expected_title}
    Sleep    3s
    ${all_texts}=    Get All Visible Text
    ${is_present}=   Run Keyword And Return Status    List Should Contain Value    ${all_texts}    ${expected_title}
    Run Keyword If    '${is_present}' == 'True'
    ...    Log To Console    ✅ Title "${expected_title}" is present
    ...  ELSE
    ...    Log To Console    ❌ Title "${expected_title}" is NOT present
    [Return]    ${is_present}


Check For Continue Watching Section
    Sleep   5s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_CONTINUE_WATCHING}
    Wait Until Page Contains Element    ${CONTINUE_WATCHING_TEXT}    timeout=${TIMEOUT}
    Wait Until Element Is Visible   ${CONTINUE_WATCHING_CONTENT}
    Sleep    2s
    Click Element    ${CONTINUE_WATCHING_CONTENT}

Move To Feed    
    [Arguments]    ${feed_name}
    Sleep   5s
    ${scrollable_xpath}=    Set Variable    new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("${feed_name}"))
    Click Element    ${SCROLL_TO_STRATEGY}=${scrollable_xpath}

Select Continue Watching Content To Play
    Sleep    2s
    Click Element    ${CONTINUE_WATCHING_CONTENT}

Personalised Recommendations
    Sleep   2s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_RECOMMENDED}
    Wait Until Page Contains Element    ${RECOMMENDED_TEXT}    timeout=${TIMEOUT}
    Log To Console    Navigated to Recommendations
    Wait Until Element Is Visible    ${RECOMMENDED_CONTENT}      timeout=${TIMEOUT}
    Click Element    ${RECOMMENDED_CONTENT}
    Handle Pin Entry If Required
    Go Back

# Navigate To Child Profile
#     Launch TV By E App In Android Phone
#     ${profiles}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROFILE_TEXT}
#     Run Keyword If    '${profiles}' == 'True'    Log To Console    Profile page is visible
#     Log To Console    ${profiles}
#     IF    ${profiles} == True
#         Sleep    3s
#         Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_CHILD_PROFILE}
#         Log    Profile selected successfully
#         ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PIN_CODE}    timeout=${TIMEOUT}
#         Run Keyword If    '${is_present}' == 'True'    Input Text    ${PIN_CODE}    ${CHILD_PASSWORD}
#         Run Keyword If    '${is_present}' == 'True'    Click Element    ${OK_BUTTON}
#         Log To Console    Admin PIN is entered
#         Handling Pop Up
#     ELSE
#         Log    Profile page is not visible
#     END

Get All Visible Text
    ${elements}=    Get Webelements    ${WEB_ELEMENTS}
    @{texts}=    Create List
    FOR    ${element}    IN    @{elements}
        ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${visible}
            ${text}=    Get Text    ${element}
            Append To List    ${texts}    ${text}
        END
    END
    [Return]    ${texts}

Child Profile With Age-Appropriate Content
    Scroll Through Home Page
    ${titles}=    Get All Visible Text
    Should Not Contain Any    ${titles}    ['violence', 'crime', 'romance']
    @{expected}=    Create List    BabyShark    Cartoon Network Arabic
    Should Contain Any    ${titles}    @{expected}
    Log To Console    "This is child profile"


Extract Title And Channel
    [Arguments]    ${index1}    ${index2}
    ${texts}=    Get All Visible Text
    ${cleaned}=  Evaluate    [x for x in ${texts} if x not in ${UNWANTED_KEYWORDS}]
    ${title}=    Get From List    ${cleaned}    ${index1}
    ${channel}=  Get From List    ${cleaned}    ${index2}
    ${titles}=   Create List    ${title}    ${channel}
    [Return]     ${titles}

Add To Favorite
    Sleep    5s
    ${is_present1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LIVE_TV_TEXT}    timeout=${TIMEOUT}
    Run Keyword If    '${is_present1}' == 'True'    Click Element    ${LIVE_TV_TEXT}
    Wait Until Page Contains    PROGRAM DETAILS
    # Tap to open program details
    Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[2]/android.widget.FrameLayout/android.widget.FrameLayout[2]
    Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[2]/android.widget.FrameLayout/android.widget.FrameLayout[3]/android.widget.FrameLayout[2]
    # Handle favorite/unfavorite logic
    ${is_fav_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FAVORITE_TEXT}    timeout=${TIMEOUT}
    ${is_unfav_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${UNFAVORITE_TEXT}    timeout=${TIMEOUT}
    Run Keyword If    ${is_fav_visible}    Click Element    ${FAVORITE_TEXT}
    Run Keyword If    ${is_fav_visible}    Log To Console    Added to favorites
#    Run Keyword If    ${is_unfav_visible}    Click Element    ${CANCEL_BUTTON}
    Run Keyword If    ${is_unfav_visible}    Log To Console    Already a favorite, no action taken
    ${titles1}=    Extract Title And Channel    ${INDEX_1}    ${INDEX_2}
    Log To Console    Final Titles=${titles1}
    Set Global Variable    ${titles1}
     Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[2]/android.widget.FrameLayout/android.widget.FrameLayout[2]
    Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout[2]/android.widget.FrameLayout/android.widget.FrameLayout[3]/android.widget.FrameLayout[2]
    Click Element       //android.widget.TextView[@text="HOME"]

Navigate To Favorites
    [Documentation]    Navigate to the Favorites feed and verify the content and functionality.
    Sleep   2s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_FAVORITES}
    Wait Until Element Is Visible    ${FAVORITE_CONTENT}
    Page Should Contain Text    FAVORITES
    Click Element    ${FAVORITE_CONTENT}
    Wait Until Page Contains    PROGRAM DETAILS
    Sleep    2s

    

Verify fav
    Navigate To Favorites
    ${titles_2}=    Extract Title And Channel    ${INDEX_1}    ${INDEX_2}
    ${titles1}=    Get Variable Value    ${titles1}
    ##    Checking the title
    ${are_equal}=    Evaluate    ${titles1} == ${titles2}
    Run Keyword If    not ${are_equal}    Fail    Titles are not the same
    Log To Console    Titles match
    Sleep    10s
    Go Back

Vod From Promotional Banner
    [Documentation]     Access VOD content from a promotional banner and verify the playback functionality.
    [Arguments]    ${SWIPE_COUNTS}
    FOR    ${i}    IN RANGE    ${SWIPE_COUNTS}
        Swipe    900    950    200    950    500
        Sleep    1s
    END
    Wait Until Element Is Visible    ${VOD_CONTENT}    timeout=${TIMEOUT}
    Click Element    ${VOD_CONTENT}
    ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PIN_CODE}    timeout=${TIMEOUT}
    Run Keyword If    '${is_present}' == 'True'    Input Text    ${PIN_CODE}    ${ADMIN_PASSWORD}
    Run Keyword If    '${is_present}' == 'True'    Click Element    ${OK_BUTTON}
    ${titles}=    Get All Visible Text
    Log To Console    ${titles}
    Sleep    5s
    @{expected}=    Create List    AUDIO    SUBTITLES    PLOT
    Should Contain Any    ${titles}    @{expected}

Accessing Epg
    [Documentation]    Access the Electronic Program Guide (EPG) and verify the displayed program information.
    Click Element    ${SEE_ALL_TEXT}
    Wait Until Element Is Visible    ${TV_GUIDE_TEXT}
    Sleep    5s

Search Functionality
    [Documentation]    Test the search functionality by entering a query and verifying the search results.
    Click Element    ${SEARCH_ICON}
    Wait Until Page Contains    SEARCH    timeout=${TIMEOUT}
    Log To Console    Search screen is Visible
    Click Element    ${SEARCH_TEXT_BOX}
    Input Text    ${SEARCH_TEXT_BOX}    ${SEARCH_TEXT}
    Click Element    ${SEARCH_CONTENT}
    Log To Console    ✅ Search result for "india" is visible
    Sleep    10s

Switching Profile
    [Documentation]    Validate profile switching functionality.
    Click Element    ${MENU_BAR}
    Wait Until Element Is Visible    ${ADMIN_PROFILE}    timeout=${TIMEOUT}
    Click Element    ${ADMIN_PROFILE}
    Click Element     ${ADMIN1_PROFILE}
    Log To Console    Switched to other profile
    Sleep    5s
    Handling Pop Up
    Validating The Profile Switching

Validating The Profile Switching
    Click Element       ${MENU_BAR}
    Page Should Contain Element    ${ADMIN1_PROFILE}

Navigate To New Releases
    [Documentation]    Navigate to the "New Releases" section of the app and verify the page load and content.
    Sleep   2s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_NEW_RELEASES}
    Wait Until Page Contains Element    ${NEW_RELEASES_TEXT}      timeout=${TIMEOUT}
    Wait Until Element Is Visible    ${NEW_RELEASES_CONTENT}
    Click Element    ${NEW_RELEASES_CONTENT}
    Handle Pin Entry If Required
    Wait Until Page Contains    MOVIE DETAILS
    Sleep    2s
    Check New Release Year

Check New Release Year
    ${texts}=    Get All Visible Text
    ${cleaned}=  Evaluate    [x for x in ${texts} if x not in ${UNWANTED_KEYWORDS}]
    Log To Console    \nFiltered List:\n${cleaned}
    Extract Year From List    ${cleaned}

Extract Year From List
    [Arguments]    ${list}
    FOR    ${item}    IN    @{list}
        ${item_str}=    Set Variable    ${item}
        ${is_year}=    Evaluate    str("${item_str}").isdigit() and len(str("${item_str}")) == 4 and ${NEW_RELEASE_YEAR_MIN} <= int("${item_str}") <= ${NEW_RELEASE_YEAR_MAX}
        Run Keyword If    ${is_year}    Evaluate Year Validity    ${item_str}
    END

Evaluate Year Validity
    ${year_int}=    Convert To Integer    ${year}
    Log To Console    >>> YEAR: ${year}
    Run Keyword If    ${START_YEAR} <= ${year_int} <= ${CURRENT_YEAR}
    ...    Log To Console    >>> This is a NEW RELEASE
    Run Keyword Unless    ${START_YEAR} <= ${year_int} <= ${CURRENT_YEAR}
    ...    Log To Console     This is NOT a new release

Verify Parental Control
    [Documentation]    Verify the functionality and effectiveness of parental control settings on the page.
    Sleep   2s
    Click Element    ${SCROLL_TO_STRATEGY}=${SCROLL_TO_LOCKED_CONTENT}
    Wait Until Page Contains Element    ${LOCKED_CONTENT_TEXT}  timeout=${TIMEOUT}
    Log To Console    Navigated to locked content
    Wait Until Element Is Visible    ${LOCKED_CONTENT}
    Click Element    ${LOCKED_CONTENT}
    Handle Pin Entry If Required

Handling Notification
    [Documentation]    Handle and verify notifications that appear on the page.
    Click Element    ${LIVE_TV_TEXT}
    Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]//android.widget.ImageView

    ${is_fav_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FAVORITE_TEXT}    timeout=${TIMEOUT}
    ${is_unfav_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${UNFAVORITE_TEXT}    timeout=${TIMEOUT}

    Run Keyword If    ${is_fav_visible}    Click Element    ${FAVORITE_TEXT}
    Run Keyword If    ${is_fav_visible}    Log To Console    Added to favorites

    # ✅ Validate notification
    ${toast_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    ////android.widget.TextView[@text='Successfully added to your favorites']    timeout=5s
    Run Keyword Unless    ${toast_present}    Fail    Notification toast not visible
    Log To Console    Notification validated: Successfully added to your favorites

Scroll Analyze Smoothness And PageEnd
    [Documentation]    Verifying scroll smoothness and checking for UI end
    ${smooth_scroll}=    Set Variable    True
    ${previous_result}=    Get All Visible Text

    FOR    ${i}    IN RANGE    ${SCROLL_COUNT}
        Log To Console    --- Scroll iteration ${i + 1} ---
        Swipe    ${SWIPE_START_X}    ${SWIPE_START_Y}    ${SWIPE_END_X}    ${SWIPE_END_Y}    ${SWIPE_DURATION}
        Sleep    ${SLEEP_TIME}

        ${gfx_output}=    Run Process    adb    shell    dumpsys gfxinfo ${PACKAGE_NAME}    stdout=True
        ${gfx_text}=      Set Variable    ${gfx_output.stdout}

        ${janky_frames}=      Extract Metric    ${gfx_text}    Janky frames
        ${missed_vsync}=      Extract Metric    ${gfx_text}    Number Missed Vsync
        ${frame_time_50}=     Extract Metric    ${gfx_text}    50th percentile
        ${frame_time_90}=     Extract Metric    ${gfx_text}    90th percentile
        ${input_latency}=     Extract Metric    ${gfx_text}    Number High input latency

        Log To Console    Janky Frames: ${janky_frames}
        Log To Console    Missed Vsync: ${missed_vsync}
        Log To Console    Frame render times (50th percentile): ${frame_time_50} ms
        Log To Console    Frame render times (90th percentile): ${frame_time_90} ms
        Log To Console    Input Latency: ${input_latency}

        Run Keyword If    ${janky_frames} > 5 or ${frame_time_90} > 20 or ${missed_vsync} > 10 or ${input_latency} > 500    Set Variable    ${smooth_scroll}    False

        ${current_result}=   Get All Visible Text
        Log To Console    Text after scroll ${i+1}: ${current_result}

        ${is_same}=    Evaluate    str(${current_result}) == str(${previous_result})
        Run Keyword If    ${is_same}    Log To Console    ✅ Reached end of page after ${i+1} scrolls
        Run Keyword If    ${is_same}    Exit For Loop

        ${previous_result}=    Set Variable    ${current_result}
        Log To Console    Scrolled ${i+1} times
    END

    Run Keyword If    ${smooth_scroll}    Log To Console    ✅ Scroll is smooth and responsive!
    Run Keyword If    not ${smooth_scroll}    Log To Console    ⚠️ Scroll might be lagging, consider optimization.
    Scroll Back To Top

Swipes
    [Arguments]    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}=500
    Run Process    adb    shell    input swipe ${start_x} ${start_y} ${end_x} ${end_y} ${duration}

Extract Metric
    [Arguments]    ${gfx_data}    ${metric_name}
    ${lines}=    Split To Lines    ${gfx_data}
    ${metric_value}=    Set Variable    0
    FOR    ${line}    IN    @{lines}
        ${normalized_line}=    Evaluate    "'${line}'.lower()"
        Run Keyword If    "${metric_name.lower()}" in ${normalized_line}    Set Variable    ${metric_value}    ${line.split(': ')[-1]}
    END
    RETURN    ${metric_value}
    Scroll Back To Top

Scroll Through Home Page
    [Documentation]    Scroll down until no new content is loaded
    ${previous_result}=   Get All Visible Text
    FOR    ${i}    IN RANGE    10
        Swipe    ${SWIPE_START_X}    ${SWIPE_START_Y}    ${SWIPE_END_X}    ${SWIPE_END_Y}    1000
        Sleep    2s

        ${current_result}=   Get All Visible Text    
        Log To Console    \nText after scroll ${i+1}: ${current_result}

        ${is_same}=    Evaluate    ${current_result} == ${previous_result}
        Run Keyword If    ${is_same}    Log To Console    Reached end of page after ${i+1} scrolls
        Run Keyword If    ${is_same}    Exit For Loop

        ${previous_result}=    Set Variable    ${current_result}
        Log To Console    Scrolled ${i+1} times
    END
    Sleep    5s