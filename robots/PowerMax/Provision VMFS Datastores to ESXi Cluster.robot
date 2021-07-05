*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/provision_vmfs_datastores_to_esxi_clusterpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Provision VMFS Datastores to ESXi Cluster Basic
    [Arguments]    &{provision_vmfs_datastores_to_esxi_cluster_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore"]
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiCluster
    Select From List By Label    id=input_esxiCluster    ${provision_vmfs_datastores_to_esxi_cluster_data.esxi_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastoreName
    Input Text    id=input_datastoreName    ${provision_vmfs_datastores_to_esxi_cluster_data.datastore_name_(for_multiple_datastores,_the_name_will_be_appended_with_volume_ids)}
    Sleep    10
    Wait Until Element Is Visible    id=input_vmfsVersion
    Select From List By Label    id=input_vmfsVersion    ${provision_vmfs_datastores_to_esxi_cluster_data.vmfs_version}
    Click Element    xpath=//a[text()="PowerMax Host Group"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${provision_vmfs_datastores_to_esxi_cluster_data.powermax_array}
    Sleep    10
    Run Keyword If    ${provision_vmfs_datastores_to_esxi_cluster_data.new_host_group?} == True    Click Element    xpath=//label[@for="input_createHostGroup"]
    Sleep    10
    Wait Until Element Is Visible    id=input_existingHostGroup
    Select From List By Label    id=input_existingHostGroup    ${provision_vmfs_datastores_to_esxi_cluster_data.existing_host_group_on_the_array}
    Click Element    xpath=//a[text()="Masking View"]
    Sleep    10
    Run Keyword If    ${provision_vmfs_datastores_to_esxi_cluster_data.new_masking_view?} == True    Click Element    xpath=//label[@for="input_createMaskingView"]
    Click Element    xpath=//a[text()=""]
    Click Element    xpath=//a[text()="Storage Group"]
    Sleep    10
    Wait Until Element Is Visible    id=input_existingStorageGroup
    Select From List By Label    id=input_existingStorageGroup    ${provision_vmfs_datastores_to_esxi_cluster_data.exisiting_storage_group_name}
    Click Element    xpath=//a[text()="Volumes"]
    Sleep    10
    Run Keyword If    ${provision_vmfs_datastores_to_esxi_cluster_data.new_volumes?} == True    Click Element    xpath=//label[@for="input_createVolumes"]
    Sleep    10
    Wait Until Element Is Visible    id=input_numberOfVolumes
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${provision_vmfs_datastores_to_esxi_cluster_data.capacity_unit_in_cyl/mb/gb/tb}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSize
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeIdentifier
    Input Text    id=input_volumeIdentifier    ${provision_vmfs_datastores_to_esxi_cluster_data.user_friendly_names_for_the_volumes_to_be_created_on_array}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
