*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/relink_vmfs_datastore_snapshotpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Relink VMFS Datastore Snapshot Basic
    [Arguments]    &{relink_vmfs_datastore_snapshot_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${relink_vmfs_datastore_snapshot_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${relink_vmfs_datastore_snapshot_data.esxi_host_or_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${relink_vmfs_datastore_snapshot_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${relink_vmfs_datastore_snapshot_data.datastore}
    Click Element    xpath=//a[text()="Storage Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_sourceStorageGroup
    Select From List By Label    id=input_sourceStorageGroup    ${relink_vmfs_datastore_snapshot_data.source_storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_targetStorageGroupName
    Select From List By Label    id=input_targetStorageGroupName    ${relink_vmfs_datastore_snapshot_data.storage_group_name_to_be_used_as_a_link_target_for_the_snapshot_generation}
    Sleep    10
    Wait Until Element Is Visible    id=input_snapshotName
    Select From List By Label    id=input_snapshotName    ${relink_vmfs_datastore_snapshot_data.snapshot_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_generation
    Select From List By Label    id=input_generation    ${relink_vmfs_datastore_snapshot_data.snapshot_generation}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
