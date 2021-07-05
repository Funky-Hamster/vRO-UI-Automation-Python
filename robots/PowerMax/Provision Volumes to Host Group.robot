*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/provision_volumes_to_host_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Provision Volumes to Host Group Basic
    [Arguments]    &{provision_volumes_to_host_group_data}
    Sleep    10
    Click Element    xpath=//a[text()="Host Group"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${provision_volumes_to_host_group_data.powermax_array}
    Sleep    10
    Run Keyword If    ${provision_volumes_to_host_group_data.new_host_group?} == True    Click Element    xpath=//label[@for="input_createHostGroup"]
    Sleep    10
    Wait Until Element Is Visible    id=input_existingHostGroup
    Select From List By Label    id=input_existingHostGroup    ${provision_volumes_to_host_group_data.existing_host_group_name}
    Click Element    xpath=//a[text()="Masking View"]
    Sleep    10
    Run Keyword If    ${provision_volumes_to_host_group_data.new_masking_view?} == True    Click Element    xpath=//label[@for="input_createMaskingView"]
    Click Element    xpath=//a[text()=""]
    Click Element    xpath=//a[text()="Storage Group"]
    Sleep    10
    Wait Until Element Is Visible    id=input_existingStorageGroup
    Select From List By Label    id=input_existingStorageGroup    ${provision_volumes_to_host_group_data.exisiting_storage_group_name}
    Click Element    xpath=//a[text()="Volumes"]
    Sleep    10
    Run Keyword If    ${provision_volumes_to_host_group_data.new_volumes?} == True    Click Element    xpath=//label[@for="input_createVolumes"]
    Click Element    xpath=//label[contains(text(),"List of exisiting volumes")]/parent::div/parent::div//option[text()="${provision_volumes_to_host_group_data.list_of_exisiting_volumes}"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
