*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/modify_host_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify Host Group Basic
    [Arguments]    &{modify_host_group_data}
    Sleep    10
    Click Element    xpath=//a[text()="Host Group Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_actionType
    Select From List By Label    id=input_actionType    ${modify_host_group_data.the_action_that_needs_to_be_performed}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostGroup
    Select From List By Label    id=input_hostGroup    ${modify_host_group_data.the_host_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_newName
    Input Text    id=input_newName    ${modify_host_group_data.new_host_group_name}
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_avoidResetBroadcast
    Select From List By Label    id=input_avoidResetBroadcast    ${modify_host_group_data.avoid_reset_broadcast}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSetAddressing
    Select From List By Label    id=input_volumeSetAddressing    ${modify_host_group_data.volume_set_addressing}
    Sleep    10
    Wait Until Element Is Visible    id=input_spc2ProtocolVersion
    Select From List By Label    id=input_spc2ProtocolVersion    ${modify_host_group_data.spc2_protocol_version}
    Sleep    10
    Wait Until Element Is Visible    id=input_scsi3
    Select From List By Label    id=input_scsi3    ${modify_host_group_data.scsi3}
    Sleep    10
    Wait Until Element Is Visible    id=input_scsiSupport1
    Select From List By Label    id=input_scsiSupport1    ${modify_host_group_data.scsi_support1}
    Sleep    10
    Wait Until Element Is Visible    id=input_disableQResetOnUa
    Select From List By Label    id=input_disableQResetOnUa    ${modify_host_group_data.disable_q_reset_on_ua}
    Sleep    10
    Wait Until Element Is Visible    id=input_environSet
    Select From List By Label    id=input_environSet    ${modify_host_group_data.environ_set}
    Sleep    10
    Wait Until Element Is Visible    id=input_openVms
    Select From List By Label    id=input_openVms    ${modify_host_group_data.open_vms}
    Sleep    10
    Run Keyword If    ${modify_host_group_data.consistent_lun} == True    Click Element    xpath=//label[@for="input_consistentLun"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
