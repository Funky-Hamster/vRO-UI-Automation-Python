*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_host_group_for_esxi_clusterpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Host Group for ESXi Cluster Basic
    [Arguments]    &{create_host_group_for_esxi_cluster_data}
    Sleep    10
    Click Element    xpath=//a[text()="Host Group Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_host_group_for_esxi_cluster_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_esxCluster
    Select From List By Label    id=input_esxCluster    ${create_host_group_for_esxi_cluster_data.esxi_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostGroupName
    Input Text    id=input_hostGroupName    ${create_host_group_for_esxi_cluster_data.host_group_name}
    Click Element    xpath=//a[text()="Host Group Flags"]
    Sleep    10
    Wait Until Element Is Visible    id=input_avoidResetBroadcast
    Select From List By Label    id=input_avoidResetBroadcast    ${create_host_group_for_esxi_cluster_data.avoid_reset_broadcast}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSetAddressing
    Select From List By Label    id=input_volumeSetAddressing    ${create_host_group_for_esxi_cluster_data.volume_set_addressing}
    Sleep    10
    Wait Until Element Is Visible    id=input_spc2ProtocolVersion
    Select From List By Label    id=input_spc2ProtocolVersion    ${create_host_group_for_esxi_cluster_data.spc2_protocol_version}
    Sleep    10
    Wait Until Element Is Visible    id=input_scsi3
    Select From List By Label    id=input_scsi3    ${create_host_group_for_esxi_cluster_data.scsi3}
    Sleep    10
    Wait Until Element Is Visible    id=input_scsiSupport1
    Select From List By Label    id=input_scsiSupport1    ${create_host_group_for_esxi_cluster_data.scsi_support1}
    Sleep    10
    Wait Until Element Is Visible    id=input_disableQResetOnUa
    Select From List By Label    id=input_disableQResetOnUa    ${create_host_group_for_esxi_cluster_data.disable_q_reset_on_ua}
    Sleep    10
    Wait Until Element Is Visible    id=input_environSet
    Select From List By Label    id=input_environSet    ${create_host_group_for_esxi_cluster_data.environ_set}
    Sleep    10
    Wait Until Element Is Visible    id=input_openVms
    Select From List By Label    id=input_openVms    ${create_host_group_for_esxi_cluster_data.open_vms}
    Sleep    10
    Run Keyword If    ${create_host_group_for_esxi_cluster_data.consistent_lun?} == True    Click Element    xpath=//label[@for="input_consistentLun"]
    Click Element    xpath=//a[text()="Reuse Host Group"]
    Sleep    10
    Run Keyword If    ${create_host_group_for_esxi_cluster_data.reuse_existing_host_group_entry_if_an_acceptable_match_is_found?} == True    Click Element    xpath=//label[@for="input_reuseIfMatchFound"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}