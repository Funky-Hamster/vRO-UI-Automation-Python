*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/add_new_esxi_host_to_esxi_clusterpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Add New ESXi Host to ESXi Cluster Basic
    [Arguments]    &{add_new_esxi_host_to_esxi_cluster_data}
    Sleep    10
    Click Element    xpath=//a[text()="Host details"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${add_new_esxi_host_to_esxi_cluster_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiHost
    Select From List By Label    id=input_esxiHost    ${add_new_esxi_host_to_esxi_cluster_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostName
    Input Text    id=input_hostName    ${add_new_esxi_host_to_esxi_cluster_data.host_name}
    Wait Until Element Is Enabled    xpath=//*[@id="availableInitiators"]/div/div[2]/div[1]/input
    Input Text    xpath=//*[@id="availableInitiators"]/div/div[2]/div[1]/input    ${add_new_esxi_host_to_esxi_cluster_data.initiators_of_the_esxi_host}
    Sleep    10
    Run Keyword If    ${add_new_esxi_host_to_esxi_cluster_data.reuse_existing_host_entry_if_an_acceptable_match_is_found} == True    Click Element    xpath=//label[@for="input_reuseIfMatchFound"]
    Click Element    xpath=//a[text()="Host Flags"]
    Sleep    10
    Wait Until Element Is Visible    id=input_scsiSupport1
    Select From List By Label    id=input_scsiSupport1    ${add_new_esxi_host_to_esxi_cluster_data.scsi_support1_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_avoidResetBroadcast
    Select From List By Label    id=input_avoidResetBroadcast    ${add_new_esxi_host_to_esxi_cluster_data.avoid_reset_broadcast_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSetAddressing
    Select From List By Label    id=input_volumeSetAddressing    ${add_new_esxi_host_to_esxi_cluster_data.volume_set_addressing_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_disableQResetOnUa
    Select From List By Label    id=input_disableQResetOnUa    ${add_new_esxi_host_to_esxi_cluster_data.disable_q_reset_on_ua_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_spc2ProtocolVersion
    Select From List By Label    id=input_spc2ProtocolVersion    ${add_new_esxi_host_to_esxi_cluster_data.spc2_protocol_version_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_scsi3
    Select From List By Label    id=input_scsi3    ${add_new_esxi_host_to_esxi_cluster_data.scsi3_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_environSet
    Select From List By Label    id=input_environSet    ${add_new_esxi_host_to_esxi_cluster_data.environ_set_powermax_host_flag}
    Sleep    10
    Wait Until Element Is Visible    id=input_openVms
    Select From List By Label    id=input_openVms    ${add_new_esxi_host_to_esxi_cluster_data.open_vms_powermax_host_flag}
    Sleep    10
    Run Keyword If    ${add_new_esxi_host_to_esxi_cluster_data.consistent_luns_powermax_host_flag} == True    Click Element    xpath=//label[@for="input_consistentLun"]
    Click Element    xpath=//a[text()="Cluster Details"]
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiCluster
    Select From List By Label    id=input_esxiCluster    ${add_new_esxi_host_to_esxi_cluster_data.esxi_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostGroup
    Select From List By Label    id=input_hostGroup    ${add_new_esxi_host_to_esxi_cluster_data.host_group}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
