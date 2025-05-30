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
    LAUNCH TV BY E APP IN ANDROID PHONE
    Log    App Launched Successfuly
    EDIT PROFILE SUBTITLE LANGUAGE