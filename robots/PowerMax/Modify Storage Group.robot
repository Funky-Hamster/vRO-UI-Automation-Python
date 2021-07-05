*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/modify_storage_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify Storage Group Basic
    [Arguments]    &{modify_storage_group_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_actionType
    Select From List By Label    id=input_actionType    ${modify_storage_group_data.modification_action}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${modify_storage_group_data.storage_group_to_modify}
    Sleep    10
    Wait Until Element Is Visible    id=input_newName
    Input Text    id=input_newName    ${modify_storage_group_data.new_name_(unique_identifier_with_maximum_length_40._case_will_be_ignored_when_checking_uniqueness.)}
    Click Element    xpath=//a[text()="SRDF Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_remoteArray1
    Select From List By Label    id=input_remoteArray1    ${modify_storage_group_data.remote_powermax_array_1}
    Click Element    xpath=//label[contains(text(),"Remote PowerMax array 1 storage group names")]/parent::div/parent::div//option[text()="${modify_storage_group_data.remote_powermax_array_1_storage_group_names}"]
    Sleep    10
    Wait Until Element Is Visible    id=input_remoteArray2
    Select From List By Label    id=input_remoteArray2    ${modify_storage_group_data.remote_powermax_array_2}
    Click Element    xpath=//label[contains(text(),"Remote PowerMax array 2 storage group names")]/parent::div/parent::div//option[text()="${modify_storage_group_data.remote_powermax_array_2_storage_group_names}"]
    Sleep    10
    Wait Until Element Is Visible    id=input_srdfForce
    Select From List By Label    id=input_srdfForce    ${modify_storage_group_data.force_(srdf)}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
