*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_snapshot_for_vmfs_datastorepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Snapshot for VMFS Datastore Basic
    [Arguments]    &{create_snapshot_for_vmfs_datastore_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${create_snapshot_for_vmfs_datastore_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${create_snapshot_for_vmfs_datastore_data.choose_esxi_host_or_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${create_snapshot_for_vmfs_datastore_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${create_snapshot_for_vmfs_datastore_data.datastore}
    Click Element    xpath=//a[text()="Storage Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_sourceStorageGroup
    Select From List By Label    id=input_sourceStorageGroup    ${create_snapshot_for_vmfs_datastore_data.source_storage_group}
    Sleep    10
    Run Keyword If    ${create_snapshot_for_vmfs_datastore_data.boolean_to_indicate_if_you_want_to_use_a_new_name_or_choose_from_an_existing_snapshot_name.} == True    Click Element    xpath=//label[@for="input_useExistingSnapshotName"]
    Sleep    10
    Wait Until Element Is Visible    id=input_newSnapshotName
    Input Text    id=input_newSnapshotName    ${create_snapshot_for_vmfs_datastore_data.enter_a_new_name_for_the_snapshot}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
