*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/link_vmfs_datastore_snapshot_to_a_new_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Link VMFS Datastore Snapshot to a New Volume Basic
    [Arguments]    &{link_vmfs_datastore_snapshot_to_a_new_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.esxi_host_or_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.datastore}
    Click Element    xpath=//a[text()="Storage information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_sourceStorageGroup
    Select From List By Label    id=input_sourceStorageGroup    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.source_storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_snapshotName
    Select From List By Label    id=input_snapshotName    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.snapshot_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_generation
    Select From List By Label    id=input_generation    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.snapshot_generation}
    Sleep    10
    Wait Until Element Is Visible    id=input_targetStorageGroupName
    Input Text    id=input_targetStorageGroupName    ${link_vmfs_datastore_snapshot_to_a_new_volume_data.storage_group_name_to_be_used_as_a_link_target_for_the_snapshot_generation}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
