*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/mount_volume_as_datastore_on_an_esxi_hostpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Mount Volume as Datastore on an ESXi Host Basic
    [Arguments]    &{mount_volume_as_datastore_on_an_esxi_host_data}
    Sleep    10
    Click Element    xpath=//a[text()="ESXi Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vCenter
    Select From List By Label    id=input_vCenter    ${mount_volume_as_datastore_on_an_esxi_host_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiHost
    Select From List By Label    id=input_esxiHost    ${mount_volume_as_datastore_on_an_esxi_host_data.esxi_host_where_volume_needs_to_be_mounted}
    Sleep    10
    Run Keyword If    ${mount_volume_as_datastore_on_an_esxi_host_data.resignature_required?
resignature_of_the_datastore_will_only_be_done_if_the_flag_is_set_to_true_(default_will_be_false).
if_the_volume_is_a_snapshot_of_an_existing_datastore,_then_mounting_the_volume_(snapshot)_to_same_host_as_the_original_datastore_requires_resignaturing.} == True    Click Element    xpath=//label[@for="input_resignatureRequired"]
    Click Element    xpath=//a[text()="Storage Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_storageArray
    Select From List By Label    id=input_storageArray    ${mount_volume_as_datastore_on_an_esxi_host_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_volume
    Select From List By Label    id=input_volume    ${mount_volume_as_datastore_on_an_esxi_host_data.volume}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${mount_volume_as_datastore_on_an_esxi_host_data.storage_group}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
