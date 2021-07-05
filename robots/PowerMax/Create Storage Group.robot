*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_storage_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Storage Group Basic
    [Arguments]    &{create_storage_group_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_storage_group_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_name
    Input Text    id=input_name    ${create_storage_group_data.name_(unique_identifier_with_maximum_length_64._case_will_be_ignored_when_checking_uniqueness.)}
    Sleep    10
    Run Keyword If    ${create_storage_group_data.enable_compression?} == True    Click Element    xpath=//label[@for="input_enableCompression"]
    Sleep    10
    Wait Until Element Is Visible    id=input_srp
    Select From List By Label    id=input_srp    ${create_storage_group_data.storage_resource_pool}
    Sleep    10
    Wait Until Element Is Visible    id=input_slo
    Select From List By Label    id=input_slo    ${create_storage_group_data.service_level}
    Sleep    10
    Run Keyword If    ${create_storage_group_data.if_true,_return_existing_storage_group_which_is_empty_and_matches_all_parameters_provided} == True    Click Element    xpath=//label[@for="input_reuseIfMatchFound"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
