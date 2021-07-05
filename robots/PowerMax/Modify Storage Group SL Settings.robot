*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/modify_storage_group_sl_settingspo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify Storage Group SL Settings Basic
    [Arguments]    &{modify_storage_group_sl_settings_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${modify_storage_group_sl_settings_data.storage_group_to_modify}
    Sleep    10
    Run Keyword If    ${modify_storage_group_sl_settings_data.enable_compression} == True    Click Element    xpath=//label[@for="input_enableCompression"]
    Sleep    10
    Wait Until Element Is Visible    id=input_srp
    Select From List By Label    id=input_srp    ${modify_storage_group_sl_settings_data.storage_resource_pool_${#storagegroup_?_"(current_value_:_"_+_#storagegroup.srp_+_")"_:_""}}
    Sleep    10
    Wait Until Element Is Visible    id=input_slo
    Select From List By Label    id=input_slo    ${modify_storage_group_sl_settings_data.service_level__${#storagegroup_?_"(current_value_:_"_+_#storagegroup.slo_+_")":_""}}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
