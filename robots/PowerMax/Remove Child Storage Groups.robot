*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/remove_child_storage_groupspo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Remove Child Storage Groups Basic
    [Arguments]    &{remove_child_storage_groups_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${remove_child_storage_groups_data.storage_group}
    Click Element    xpath=//label[contains(text(),"Child storage groups")]/parent::div/parent::div//option[text()="${remove_child_storage_groups_data.child_storage_groups}"]
    Sleep    10
    Run Keyword If    ${remove_child_storage_groups_data.force_execution_regardless_of_potential_data_unavailability?} == True    Click Element    xpath=//label[@for="input_force"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
