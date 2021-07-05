*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/delete_vmfs_datastore_and_powermax_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Delete VMFS Datastore and PowerMax Volume Basic
    [Arguments]    &{delete_vmfs_datastore_and_powermax_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${delete_vmfs_datastore_and_powermax_volume_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${delete_vmfs_datastore_and_powermax_volume_data.choose_host_or_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${delete_vmfs_datastore_and_powermax_volume_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${delete_vmfs_datastore_and_powermax_volume_data.datastore}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
