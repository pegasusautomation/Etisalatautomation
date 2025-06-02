########################################################
#File Name:  ANDROID_PHONE_Functions
#Description: Contains the Keyword implementations for Android Phones Using ANDROID PHONE
#Created by: 
#Created Date: 
#Reveiwed By: 
#Copy Rights: TV by e &
########################################################

*** Settings ***

Library         Process
Library         AppiumLibrary     run_on_failure=No Operation
Library    AppiumLibrary
Library         OperatingSystem
Library         String
Library         Collections
Library         DateTime
Library         C:/D_Drive/Etisalatautomation/Lib/Python/Appium_Function.py
Variables	C:/D_Drive/Etisalatautomation/Variables/Generic/Home.yaml
Library    XML



*** Keywords ***


TEST SETUP GENERIC ANDROID PHONE
    [Documentation]    Launches the app without resetting app data
    Run Keyword And Ignore Error    Terminate Application    com.huawei.phone.elife
    Sleep    2s
    Open Application    http://localhost:4723
    ...    platformName=Android
    ...    deviceName=AndroidDevice
    ...    appPackage=com.huawei.phone.elife
    ...    appActivity=ae.etisalat.elifeon.activities.MainActivity
    ...    automationName=UiAutomator2
    ...    noReset=true
    ...    autoGrantPermissions=true
    ...    newCommandTimeout=120
    Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]    15s

    ${deviceidvar}=    Run Keyword And Return Status    Get Capability    udid
    ${deviceid}=       Run Keyword If    "${deviceidvar}" == "True"    Get Capability    udid
    ...                ELSE    Get Capability    deviceUDID
    Log To Console     Deviceid:${deviceid}

Selecting Profile
    [Arguments]    ${PROFILE}    ${PASSWORD}
    ${profiles}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROFILE_TEXT}    timeout=${TIMEOUT}
    Run Keyword If    '${profiles}' == 'True'    Log To Console    Profile page is visible
    Log To Console    ${profiles}
    
    IF    ${profiles} == True
        Sleep    5s

        # Scroll if it's Child Profile
        Run Keyword If    '${PROFILE}' == '${ADMIN1_PROFILE}''
        
        Click Element    ${PROFILE}
        Log    ${PROFILE} selected successfully
        
        ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PIN_CODE}    timeout=${TIMEOUT}
        IF    ${is_present}
            Input Text    ${PIN_CODE}    ${PASSWORD}
            Click Element    ${OK_BUTTON}
            Log To Console    PIN entered
        END
        ${popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CANCEL_BUTTON}    timeout=${TIMEOUT}
        Run Keyword If    ${popup_present}    Handling Pop Up
    ELSE
        Log    Profile page is not visible
    END

SWIPE RIGHT 
    Swipe    955    223    197    223    800

LOGIN PROFILE
    Open Application  http://localhost:4723/wd/hub   platformName=Android  appActivity=ae.etisalat.elifeon.activities.MainActivity  appPackage=com.huawei.phone.elife  automationName=UiAutomator2  autoWebview=false  noReset=true  newCommandTimeout=120
    ${deviceidvar}  run keyword and return status   Get Capability  udid
	${deviceid}    RUN KEYWORD IF  "${deviceidvar}"=="${True}"     Get Capability  udid
	...     ELSE    Get Capability  deviceUDID
    log to console   Deviceid:${deviceid}
	Sleep    20s
	Click Element    xpath=//android.widget.EditText
    Clear Text    xpath=//android.widget.EditText
	Input Text    xpath=//android.widget.EditText[@text='Username']    tch011
	Click Element    xpath=//android.widget.EditText[@text='Password']
	Input Text    xpath=//android.widget.EditText[@text='Password']    2222
    
LAUNCH TV BY E APP IN ANDROID PHONE
	Open Application  http://localhost:4723/wd/hub   platformName=Android  appActivity=ae.etisalat.elifeon.activities.MainActivity  appPackage=com.huawei.phone.elife  automationName=UiAutomator2  autoWebview=false  noReset=true  newCommandTimeout=120
    ${deviceidvar}  run keyword and return status   Get Capability  udid
	${deviceid}    RUN KEYWORD IF  "${deviceidvar}"=="${True}"     Get Capability  udid
	...     ELSE    Get Capability  deviceUDID
    log to console   Deviceid:${deviceid}
	Sleep    20s
	# ${profiles}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Profiles']
	# Run Keyword If    '${profiles}' == 'True'
	# ...    Log To Console    Profile page is visible
	# Log    ${profiles}
	# IF    ${profiles}== True
	# 	Sleep    5s
	# 	Click Text    	Admin
	# 	Sleep    20s
    #     Log    Admin Selected successfuly
	# 	${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
	# 	Run Keyword If    '${is_present}' == 'True'
	# 	...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    2222
	# 	Click Element    xpath=//android.widget.TextView[@text='OK']
	# 	Log    Admin pin is entered
	# 	${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
	# 	Run Keyword If    '${is_present}' == 'True'
	# 	...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    1234
	# 	Log    user1 pin is entered
	# 	Click Element    xpath=//android.widget.TextView[@text='OK']
	# 	Log    Profile got logged in

	# ELSE
	# 	Log    Profile page is not visible
	# END

ENSURE PROFILE EXISTS
    LAUNCH TV BY E APP IN ANDROID PHONE
	Log To Console    Checking for profile
	${max_swipes}=    Set Variable    3
	
	${Profile_found}=    Run Keyword And Return Status    Element Should Be Visible    xapth=//android.widget.TextView[@text='user1']
    Run Keyword If    ${Profile_found}    Return From Keyword
	
	SWIPE RIGHT
	${Profile_found}=    Run Keyword And Return Status    Element Should Be Visible    xapth=//android.widget.TextView[@text='user1']
    Run Keyword If    ${Profile_found}    Return From Keyword

    CREATE PROFILE
	
Handling Pop Up
    Sleep	2s
    ${popup_present}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CANCEL_BUTTON}    timeout=${TIMEOUT}

    Run Keyword If    ${popup_present}
    ...    Click Element    ${CANCEL_BUTTON}
    Log To Console    Pop-up handled


	

CREATE PROFILE
    # LAUNCH TV BY E APP IN ANDROID PHONE
	${profiles}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Profiles']
	Run Keyword If    '${profiles}' == 'True'
	...    Log To Console    Profile page is visible
	Log    ${profiles}
	IF    ${profiles}== True
		Sleep    5s
		${Profile_found}=    Run Keyword And Return Status    Element Should Be Visible    xapth=//android.widget.TextView[@text='Admin']
        Run Keyword If    ${Profile_found}    Return From Keyword
		Swipe    235    216    1016    255
		Click Text    	Admin
		Sleep    20s
        Log    Admin Selected successfuly
		${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
		Run Keyword If    '${is_present}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    2222
		Click Element    xpath=//android.widget.TextView[@text='OK']
		Log    Admin pin is entered
	ELSE
		Log    Profile page is not visible
	END
    Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    creating profile

	Click Element    xpath=//android.widget.ImageView[@class='android.widget.ImageView']
	# Run Process    adb    shell    input    tap    59    102    shell=True
	Sleep    5s 
	Click Text    	Admin
	Click Element    xpath=//android.widget.TextView[@text='New Profile']
	${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
		Run Keyword If    '${is_present}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    2222
		Click Element    xpath=//android.widget.TextView[@text='OK']
	${Add_profile_name}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Add Profile Name']    timeout=5s
		Run Keyword If    '${Add_profile_name}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Add Profile Name']    user1
    Log    Added profile name
    ${Choose_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Choose Pass Code*']    timeout=5s
		Run Keyword If    '${Choose_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Choose Pass Code*']    1234
	Log    Entered the Pass code
	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
	Log    Confirmed the pass code
	${Age}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='AGE*']    timeout=5s
		Run Keyword If    '${Age}' == 'True'
		...    Click Element    xpath=//android.widget.TextView[@text='AGE*']
		Click A Point    889    2058 
		Click Element    xpath=//android.widget.TextView[@text='Done']

		Log    Entered the age
		Sleep    2s
	    # ${year_text}=    Get Text    xpath=(//android.widget.TextView[@text='01/01/1971'])
		# Log To Console    ${year_text}
	${Nationality}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='NATIONALITY*']    timeout=5s
		Run Keyword If    '${Nationality}' == 'True'
		...    Click Element    xpath=//android.widget.TextView[@text='NATIONALITY*']
	Click Element    android=new UiScrollable(new UiSelector().scrollable(true)).scrollIntoView(new UiSelector().text("India"))
    Click Text    Done
	${Location}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='LOCATION*']    timeout=5s
		Run Keyword If    '${Location}' == 'True'
		...    Click Element    xpath=//android.widget.TextView[@text='LOCATION*']
    Click Text    Dubai
    Click Text    Done
	Click Element    xpath=//android.widget.TextView[@text='Create Profile']
	${Profile_creation}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Thanks for completing this profile!']
        Run Keyword If    '${Profile_creation}' == 'True'
		...   Log    Profile creation is success
	Page Should Contain Text    Thanks for completing this profile!
	Log To Console    Subtitle language successfully changed to ${subtitle_lang}
    Click Text    GO TO MY LIST
    Run Process    adb    shell    input    tap    59    102    shell=True
    Click Element    xpath=//android.widget.TextView[@text='HOME']
	

EDIT PROFILE AUDIO LANGUAGE
    
	Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    creating profile
	Sleep    10s
	${if_present}=       Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']
	Run Keyword If    '${if_present}' == 'True'
	...    Click Element     xpath=//android.widget.TextView[@text='CANCEL']
	
	# Click Element    xpath=//android.widget.FrameLayout[@class='android.widget.FrameLayout']
	Log    Menu is Selected
	Click A Point    53    161
	Sleep    10s
	# ${cancel}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']    timeout=5s
	# 	Run Keyword If    '${cancel}' == 'True'
	# 	...    Log    clicked
	# Click Element    xpath=//android.widget.TextView[@text='CANCEL']
	Click Text    	user1
	Sleep    5s
	${if_user1_is present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='user1']    timeout=5s
		Run Keyword If    '${if_user1_is present}' == 'True'
		...    Click Element    xpath=//android.widget.TextView[@text='user1']
		
	
	# Click Element    xpath=//android.widget.TextView[@text='user1']
	# Click A Point    221    425
	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
		Click Element    xpath=//android.widget.TextView[@text='OK']
	
	Scroll Down    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
	Click Element    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
    Click Element    xpath=//android.widget.TextView[@text='English']
	Click Element    xpath=//android.widget.TextView[@text='Done']
    Log    Audio Language changed to English
	Click Element    xpath=//android.widget.TextView[@text='Done']

EDIT PROFILE SUBTITLE LANGUAGE
    
	Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    creating profile
	Sleep    10s
	${if_present}=       Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']
	Run Keyword If    '${if_present}' == 'True'
	...    Click Element     xpath=//android.widget.TextView[@text='CANCEL']
	
	
	Log    Menu is Selected
	Click A Point    53    161
	Sleep    10s
	
	Click Text    	user1
	Sleep    5s
	Click Text    	user1
	Sleep    3s

	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
		Click Element    xpath=//android.widget.TextView[@text='OK']
	
	Scroll Down    xpath=//android.widget.TextView[@text='SUBTITLES LANGUAGE 1']
	Click Element    xpath=//android.widget.TextView[@text='SUBTITLES LANGUAGE 1']
    Click Element    xpath=//android.widget.TextView[@text='English']
	Click Element    xpath=//android.widget.TextView[@text='Done']
    Log    Audio Language changed to English
	Click Element    xpath=//android.widget.TextView[@text='Done']

DELETE PROFILE
    LAUNCH TV BY E APP IN ANDROID PHONE
	Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    creating profile
	Click Element    xpath=//android.widget.ImageView[@class='android.widget.ImageView']
	Sleep    2s
	Click Text    	user1
	Click Text    	user1
	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
		Click Element    xpath=//android.widget.TextView[@text='OK']
	
    Click Text    Delete Profile
    

EDIT PROFILE NAME
    NAVIGATE TO PROFILE
    Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    Editing profile name
	Sleep    10s
	${if_present}=       Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']
	Run Keyword If    '${if_present}' == 'True'
	...    Click Element     xpath=//android.widget.TextView[@text='CANCEL']
	Sleep    5s
	Click Element    xpath=//android.widget.ImageView[@class='android.widget.ImageView']
	Sleep    2s 
	Log    Menu is Selected
	Click A Point    53    161
	Sleep    10s
	# Click Text    	user1
	# Sleep    2s
	Click A Point    221    425
	# Click Element    xpath=//android.widget.FrameworkLayout[.//android.widget.TexxtView[@text='user1']]
	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
		Click Element    xpath=//android.widget.TextView[@text='OK']
	

EDIT PROFILE AUDIO LANGUAGES
    
	Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Log To Console    creating profile
	Sleep    10s
	${if_present}=       Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']
	Run Keyword If    '${if_present}' == 'True'
	...    Click Element     xpath=//android.widget.TextView[@text='CANCEL']
	
	# Click Element    xpath=//android.widget.FrameLayout[@class='android.widget.FrameLayout']
	Log    Menu is Selected
	Click A Point    53    161
	Sleep    10s
	# ${cancel}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']    timeout=5s
	# 	Run Keyword If    '${cancel}' == 'True'
	# 	...    Log    clicked
	# Click Element    xpath=//android.widget.TextView[@text='CANCEL']
	Click Text    	ASSIST
	Sleep    3s
	Click Element    xpath=//android.widget.TextView[@text='Profiles']
	Click Element    xpath=//android.widget.TextView[@text='user1']
	${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
		Run Keyword If    '${confirm_pass_code}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
		Click Element    xpath=//android.widget.TextView[@text='OK']
	
	Scroll Down    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
	Click Element    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
    Click Element    xpath=//android.widget.TextView[@text='English']
	Click Element    xpath=//android.widget.TextView[@text='Done']
    Log    Audio Language changed to English
	Click Element    xpath=//android.widget.TextView[@text='Done']

NAVIGATE TO PROFILE
    
	${profiles}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='Profiles']
	Run Keyword If    '${profiles}' == 'True'
	...    Log To Console    Profile page is visible
	Log    ${profiles}
	IF    ${profiles}== True
		Sleep    5s
		Click Text    	User1
		Sleep    20s
        Log    user1 Selected successfuly
		${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
		Run Keyword If    '${is_present}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    2222
		Click Element    xpath=//android.widget.TextView[@text='OK']
		Log To Console    admin pin is entered
		Log To Console    Enter the user1 pin
		${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='PIN Code']    timeout=5s
		Run Keyword If    '${is_present}' == 'True'
		...    Input Text    xpath=//android.widget.EditText[@text='PIN Code']    1234
		Log    user1 pin is entered
		Click Element    xpath=//android.widget.TextView[@text='OK']
		Log    Profile got logged in

	ELSE
		Log    Profile page is not visible
	END