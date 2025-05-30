*** Settings ***
Library    Process
Library    BuiltIn
Library    String
Library    Collections
Library    OperatingSystem

*** Variables ***
${TAP_CONFIG_FILE}    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/tap_mobile_coordinates.json
# ${TAP_CONFIG_FILE}    C:/D_Drive/Etisalat_Android/Etisalat_Android/TestSuite/tap_tab_coordinates.json

*** Keywords ***
Tap Based On Action And Resolution
    [Arguments]    ${action}
    # Read JSON file content as string
    ${json_text}=    Get File    ${TAP_CONFIG_FILE}
    # Parse JSON text into a dictionary
    ${json}=    Evaluate    json.loads('''${json_text}''')    modules=json

    ${res_output}=    Run Process    adb    shell    wm size    shell=True
    ${res_stdout}=    Set Variable    ${res_output.stdout}
    ${resolution}=    Evaluate    '${res_stdout}'.strip().split(":")[1].strip()

    ${dpi_output}=    Run Process    adb    shell    wm density    shell=True
    ${dpi_stdout}=    Set Variable    ${dpi_output.stdout}
    ${dpi_lines}=     Split To Lines    ${dpi_stdout}

    ${dpi}=    Set Variable    NONE
    FOR    ${line}    IN    @{dpi_lines}
        Run Keyword If    'Physical density' in '${line}'    Set Test Variable    ${dpi}    ${line.split(":")[1].strip()}
    END

    ${key}=    Set Variable    ${resolution}_${dpi}
    Log To Console    Screen Resolution: ${resolution}, DPI: ${dpi}, Action: ${action}
    
    ${action_dict}=    Get From Dictionary    ${json}    ${action}
    ${coords}=         Get From Dictionary    ${action_dict}    ${key}
    Run Keyword If    '${coords}' == ''    Fail    No tap coordinates for action: ${action}, key: ${key}

    ${x}=    Evaluate    '${coords}'.split(",")[0]
    ${y}=    Evaluate    '${coords}'.split(",")[1]

    Log To Console    Tapping at ${x}, ${y} for action: ${action}
    Run Process    adb    shell    input    tap    ${x}    ${y}    shell=True
