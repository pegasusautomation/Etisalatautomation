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
Resource    C:/D_Drive/Etisalat_Android/Etisalat_Android/Lib/Robot/ANDROID_PHONE/ANDROID_PHONE_Functions.robot

*** Test Cases ***
Create_Profile: Verify that user is able to create a profile
    [Setup]    TEST SETUP GENERIC ANDROID PHONE
    # LAUNCH TV BY E APP IN ANDROID PHONE
    CREATE PROFILE

    Log To Console    Profile created successfully
    
