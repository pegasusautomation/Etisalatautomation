# *** Settings ***
# Documentation   MediaFirst Basic Playback Matrix Test SuiteSetup
# Resource        C:\Users\40013838\Etisalat_Android\GenericFunctions.robot
# Library  Collections
# Library    String
# *** Keywords ***

# TEST SETUP
#     Open Application  http://localhost:4723/wd/hub   platformName=Android  appActivity=ae.etisalat.elifeon.activities.MainActivity  appPackage=com.huawei.phone.elife  automationName=UiAutomator2  autoWebview=false  noReset=true  newCommandTimeout=120
#     ${deviceidvar}  run keyword and return status   Get Capability  udid
# 	${deviceid}    RUN KEYWORD IF  "${deviceidvar}"=="${True}"     Get Capability  udid
# 	...     ELSE    Get Capability  deviceUDID
#     log to console   Deviceid:${deviceid}
    
# TEST FAIL TEARDOWN
#     ${keyword}=  Catenate  ${TEST_DEVICE}_Functions.TEST FAIL TEARDOWN ${TEST_DEVICE}
#     run keyword  ${keyword}

