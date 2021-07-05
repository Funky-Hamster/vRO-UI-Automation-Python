*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/delete_rdm_device_and_powermax_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Delete RDM Device and PowerMax Volume Basic
    [Arguments]    &{delete_rdm_device_and_powermax_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_vm
    Select From List By Label    id=input_vm    ${delete_rdm_device_and_powermax_volume_data.select_vm}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdmDev
    Select From List By Label    id=input_rdmDev    ${delete_rdm_device_and_powermax_volume_data.select_rdm_disk_to_delete}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
