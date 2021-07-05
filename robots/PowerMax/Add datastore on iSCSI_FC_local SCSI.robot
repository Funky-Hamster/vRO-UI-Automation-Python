*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/add_datastore_on_iscsi_fc_local_scsipo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Add datastore on iSCSI_FC_local SCSI Basic
    [Arguments]    &{add_datastore_on_iscsi_fc_local_scsi_data}
    Sleep    10
    Click Element    xpath=//a[text()="Select a Host"]
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${add_datastore_on_iscsi_fc_local_scsi_data.esxi_host}
    Click Element    xpath=//a[text()="Select disk"]
    Sleep    10
    Wait Until Element Is Visible    id=input_diskName
    Select From List By Label    id=input_diskName    ${add_datastore_on_iscsi_fc_local_scsi_data.disk/lun_name}
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_vmfsVersion
    Select From List By Label    id=input_vmfsVersion    ${add_datastore_on_iscsi_fc_local_scsi_data.vmfs_version}
    Click Element    xpath=//a[text()="Properties"]
    Sleep    10
    Wait Until Element Is Visible    id=input_datastoreName
    Input Text    id=input_datastoreName    ${add_datastore_on_iscsi_fc_local_scsi_data.datastore_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_capacity
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
