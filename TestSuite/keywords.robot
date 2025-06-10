*** Settings ***
Library    Process
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem

*** Variables ***
${TAP_CONFIG_FILE}    C:/D_Drive/Etisalatautomation/TestSuite/tap_mobile_coordinates.json
# ${TAP_CONFIG_FILE}    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/tap_tab_coordinates.json

*** Keywords ***
*** Keywords ***
Tap Based On Action And Resolution
    [Arguments]    ${action}
    
    # Read JSON config
    ${json_text}=    Get File    ${TAP_CONFIG_FILE}
    ${json}=    Evaluate    json.loads('''${json_text}''')    modules=json

    # Get only the Physical resolution
    ${res_output}=    Run Process    adb    shell    wm size    shell=True
    ${res_stdout}=    Set Variable    ${res_output.stdout}
    ${res_lines}=     Split To Lines    ${res_stdout}
    ${resolution}=    Set Variable    NONE
    FOR    ${line}    IN    @{res_lines}
        Run Keyword If    'Physical size' in '${line}'    Set Test Variable    ${resolution}    ${line.split(":")[1].strip()}
    END

    # Get only the Physical density
    ${dpi_output}=    Run Process    adb    shell    wm density    shell=True
    ${dpi_stdout}=    Set Variable    ${dpi_output.stdout}
    ${dpi_lines}=     Split To Lines    ${dpi_stdout}
    ${dpi}=    Set Variable    NONE
    FOR    ${line}    IN    @{dpi_lines}
        Run Keyword If    'Physical density' in '${line}'    Set Test Variable    ${dpi}    ${line.split(":")[1].strip()}
    END

    # Compose key and tap
    ${key}=    Set Variable    ${resolution}_${dpi}
    Log To Console    Screen Resolution: ${resolution}, DPI: ${dpi}, Action: ${action}

    ${action_dict}=    Get From Dictionary    ${json}    ${action}
    ${coords}=         Get From Dictionary    ${action_dict}    ${key}
    Run Keyword If    '${coords}' == ''    Fail    No tap coordinates for action: ${action}, key: ${key}

    ${x}=    Evaluate    '${coords}'.split(",")[0]
    ${y}=    Evaluate    '${coords}'.split(",")[1]

    Log To Console    Tapping at ${x}, ${y} for action: ${action}
    Run Process    adb    shell    input    tap    ${x}    ${y}    shell=True
