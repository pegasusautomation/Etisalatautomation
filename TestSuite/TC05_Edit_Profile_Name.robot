########################################################
#Script Name: Create profile
#Description:  Verify user is able to create the profile
#Created by: 
#Created Date: 
#Ported to Browser by: 
#Reveiwed By: 
#Copy Rights: TV by e
########################################################
*** Settings ***
Documentation   TV by E & App Validation
Library    AppiumLibrary
Resource       C:/D_Drive/Etisalat_Android/Etisalat_Android/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot
*** Test Cases ***
Edit_Profile_Audio_Language: Verify that user is able to Edit the profile
    NAVIGATE TO PROFILE
        # Click Element    xpath=//android.widget.FrameworkLayout[.//android.widget.TexxtView[@text='user1']]
    ${confirm_pass_code}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    timeout=5s
        Run Keyword If    '${confirm_pass_code}' == 'True'
        ...    Input Text    xpath=//android.widget.EditText[@text='Confirm Pass Code*']    1234
        Click Element    xpath=//android.widget.TextView[@text='OK']
        
