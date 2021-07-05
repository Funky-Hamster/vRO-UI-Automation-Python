*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_masking_viewpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Masking View Basic
    [Arguments]    &{create_masking_view_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_masking_view_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_viewName
    Input Text    id=input_viewName    ${create_masking_view_data.masking_view_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_initiatorGroupType
    Select From List By Label    id=input_initiatorGroupType    ${create_masking_view_data.host_or_hostgroup_type}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${create_masking_view_data.host}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${create_masking_view_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_portGroup
    Select From List By Label    id=input_portGroup    ${create_masking_view_data.port_group}
    Sleep    10
    Run Keyword If    ${create_masking_view_data.if_true,_return_existing_masking_view_which_matches_all_parameters_provided} == True    Click Element    xpath=//label[@for="input_reuseIfMatchFound"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
