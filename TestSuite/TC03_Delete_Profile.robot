########################################################
#Script Name: Create profile
#Description:  Verify user is able to delete the profile
#Created by: 
#Created Date: 
#Reveiwed By: 
#Copy Rights: TV by e
########################################################

*** Settings ***
Documentation      Verify user able to delete the profile
Library    AppiumLibrary
Resource       C:/D_Drive/Etisalat_Android/Etisalat_Android/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot
*** Test Cases ***
Create_Profile: Verify that user is able to delete a profile
    LAUNCH TV BY E APP IN ANDROID PHONE
    DELETE PROFILE

    Log To Console    Profile deleted successfully