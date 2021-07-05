*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/delete_vmfs_datastore_snapshotpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Delete VMFS Datastore Snapshot Basic
    [Arguments]    &{delete_vmfs_datastore_snapshot_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${delete_vmfs_datastore_snapshot_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${delete_vmfs_datastore_snapshot_data.esxi_host_or_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${delete_vmfs_datastore_snapshot_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${delete_vmfs_datastore_snapshot_data.datastore}
    Click Element    xpath=//a[text()="Storage information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_sourceStorageGroup
    Select From List By Label    id=input_sourceStorageGroup    ${delete_vmfs_datastore_snapshot_data.source_storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_snapshotName
    Select From List By Label    id=input_snapshotName    ${delete_vmfs_datastore_snapshot_data.snapshot_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_generation
    Select From List By Label    id=input_generation    ${delete_vmfs_datastore_snapshot_data.snapshot_generation}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
