*** Settings ***
*** Settings ***
Variables       C:/Users/40013838/Etisalat_Android/Variables/Generic/Config.yaml
Resource        C:/Users/40013838/Etisalat_Android/Lib/Robot/${TEST_DEVICE}/${TEST_DEVICE}_Functions.robot
*** Keywords ***

# TEST SETUP
#     Open Application  http://localhost:4723/wd/hub   platformName=Android  appActivity=ae.etisalat.elifeon.activities.MainActivity  appPackage=com.huawei.phone.elife  automationName=UiAutomator2  autoWebview=false  noReset=true  newCommandTimeout=120
#     ${deviceidvar}  run keyword and return status   Get Capability  udid
# 	${deviceid}    RUN KEYWORD IF  "${deviceidvar}"=="${True}"     Get Capability  udid
# 	...     ELSE    Get Capability  deviceUDID
#     log to console   Deviceid:${deviceid}


TEST SETUP GENERIC
	${keyword}=  Catenate  ${TEST_DEVICE}_Functions.TEST SETUP GENERIC ${TEST_DEVICE}
    ${RESULT}  run keyword  ${keyword}
    [Return]  ${RESULT}


TEST FAIL TEARDOWN GENERIC
	${keyword}=  Catenate  ${TEST_DEVICE}_Functions.TEST FAIL TEARDOWN GENERIC ${TEST_DEVICE}
    ${RESULT}  run keyword  ${keyword}
    [Return]  ${RESULT}