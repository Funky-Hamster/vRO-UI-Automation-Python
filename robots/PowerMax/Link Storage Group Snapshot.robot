*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/link_storage_group_snapshotpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Link Storage Group Snapshot Basic
    [Arguments]    &{link_storage_group_snapshot_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${link_storage_group_snapshot_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_snapshotName
    Select From List By Label    id=input_snapshotName    ${link_storage_group_snapshot_data.snapshot}
    Sleep    10
    Wait Until Element Is Visible    id=input_generation
    Select From List By Label    id=input_generation    ${link_storage_group_snapshot_data.generation}
    Sleep    10
    Run Keyword If    ${link_storage_group_snapshot_data.link_existing_storage_group?} == True    Click Element    xpath=//label[@for="input_useExistingStorageGroupToLink"]
    Sleep    10
    Wait Until Element Is Visible    id=input_newLinkStorageGroupName
    Input Text    id=input_newLinkStorageGroupName    ${link_storage_group_snapshot_data.name_for_the_linked_target_storage_group}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
