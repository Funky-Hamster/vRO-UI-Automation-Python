*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_storage_group_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Storage Group SRDF Protection Basic
    [Arguments]    &{create_storage_group_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_storage_group_srdf_protection_data.source_powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${create_storage_group_srdf_protection_data.source_storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_replicationMode
    Select From List By Label    id=input_replicationMode    ${create_storage_group_srdf_protection_data.srdf_replication_mode}
    Sleep    10
    Run Keyword If    ${create_storage_group_srdf_protection_data.autoselect_rdf_group?} == True    Click Element    xpath=//label[@for="input_autoselectRDFGroup"]
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${create_storage_group_srdf_protection_data.the_rdf_group_on_source_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_remoteStorageGroupName
    Input Text    id=input_remoteStorageGroupName    ${create_storage_group_srdf_protection_data.name_for_the_target_storage_group}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_establish
    Select From List By Label    id=input_establish    ${create_storage_group_srdf_protection_data.establish_flag:_specifies_if_the_pairs_are_to_be_established_on_creation}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
