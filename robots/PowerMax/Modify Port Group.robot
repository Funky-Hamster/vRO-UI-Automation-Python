*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/modify_port_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify Port Group Basic
    [Arguments]    &{modify_port_group_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_actionType
    Select From List By Label    id=input_actionType    ${modify_port_group_data.the_action_that_needs_to_be_performed}
    Sleep    10
    Wait Until Element Is Visible    id=input_portGroup
    Select From List By Label    id=input_portGroup    ${modify_port_group_data.port_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_newName
    Input Text    id=input_newName    ${modify_port_group_data.new_port_group_name}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
