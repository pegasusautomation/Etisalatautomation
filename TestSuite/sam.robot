*** Settings ***
Library    YAMLLibrary

*** Test Cases ***
Test YAML Load
    ${data}=    Load YAML File    test.yaml
    Log To Console    ${data}
