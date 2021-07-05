*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/get_initiator_aliaspo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Get Initiator Alias Basic
    [Arguments]    &{get_initiator_alias_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${get_initiator_alias_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_initiator
    Select From List By Label    id=input_initiator    ${get_initiator_alias_data.initiator}
    Sleep    10
    Wait Until Element Is Visible    id=input_port
    Select From List By Label    id=input_port    ${get_initiator_alias_data.port}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
