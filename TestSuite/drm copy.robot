########################################################
#Script Name: Edit profile audio language
#Description:  Verify user is able to change the audio language
#Created by: 
#Created Date: 
#Reveiwed By: 
#Copy Rights: TV by e
########################################################
*** Settings ***
Documentation   Verify user able to change the audio language
Library    AppiumLibrary
Resource       C:/D_Drive/Etisalatautomation/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot
*** Test Cases ***
Edit_Profile_Audio_Language: Verify that user is able to Edit the profile

    NAVIGATE TO PROFILE
    Sleep    10s
    ${cancel}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='CANCEL']    timeout=5s
		Run Keyword If    '${cancel}' == 'True'
		...    Log    clicked
	    Click Element    xpath=//android.widget.TextView[@text='CANCEL']
	Wait Until Page Contains    HOME
	${home_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='HOME']
	Run Keyword If    '${home_present}' == 'True'
	...    Log To Console    Navigated to Home screen
	Sleep    2s
	Click Element    xpath=//android.widget.ImageView[@class='android.widget.ImageView']
    Log    Successfully navigated to Profile page
	Sleep    2s
    Click Text    	User1
	Sleep    5s
    # Click Text    Admin
	Run Process    adb    shell    input    tap    999    319    shell=True
	

	# Execute Adb Shell    input tap 999 319
	# Click A Point    999    319
	# ${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
	# 	Run Keyword If    '${confirm_pass_code}' == 'True'
	# 	...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
	# 	Log    Pin entered
    #     Click Element    xpath=//android.widget.TextView[@text='OK']
	# Click Element    xpath=//android.widget.TextView[@text='Profiles']
	# Click Element    xpath=//android.widget.TextView[@text='user1']
	# ${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
	# 	Run Keyword If    '${confirm_pass_code}' == 'True'
	# 	...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
	# 	Log    Pin entered
    #     Click Element    xpath=//android.widget.TextView[@text='OK']
	# Log    Scroll till the audio language
	# Scroll Down    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
	# Click Element    xpath=//android.widget.TextView[@text='AUDIO LANGUAGE 1']
    # Log    Select the audio language
    # Click Element    xpath=//android.widget.TextView[@text='English']
	# Click Element    xpath=//android.widget.TextView[@text='Done']
    # Log    Audio Language changed to English
	# Click Element    xpath=//android.widget.TextView[@text='Done']

