*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/get_storage_group_rdf_pairs_(bulk)po.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Get Storage Group RDF Pairs (Bulk) Basic
    [Arguments]    &{get_storage_group_rdf_pairs_(bulk)_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${get_storage_group_rdf_pairs_(bulk)_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupName
    Select From List By Label    id=input_storageGroupName    ${get_storage_group_rdf_pairs_(bulk)_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${get_storage_group_rdf_pairs_(bulk)_data.rdf_group}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
