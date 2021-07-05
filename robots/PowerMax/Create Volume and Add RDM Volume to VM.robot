*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_volume_and_add_rdm_volume_to_vmpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Volume and Add RDM Volume to VM Basic
    [Arguments]    &{create_volume_and_add_rdm_volume_to_vm_data}
    Sleep    10
    Click Element    xpath=//a[text()="Volume"]
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Input Text    id=input_capacityUnit    ${create_volume_and_add_rdm_volume_to_vm_data.capacity_unit_in_mb/gb}
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_volume_and_add_rdm_volume_to_vm_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSize
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeIdentifier
    Input Text    id=input_volumeIdentifier    ${create_volume_and_add_rdm_volume_to_vm_data.volume_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${create_volume_and_add_rdm_volume_to_vm_data.the_storage_group_associated_with_the_vm,_the_volume_is_associated_with_this_group}
    Click Element    xpath=//a[text()="RDM"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vm
    Select From List By Label    id=input_vm    ${create_volume_and_add_rdm_volume_to_vm_data.virtual_machine}
    Sleep    10
    Wait Until Element Is Visible    id=input_compatibilityMode
    Select From List By Label    id=input_compatibilityMode    ${create_volume_and_add_rdm_volume_to_vm_data.compatibility_mode}
    Sleep    10
    Wait Until Element Is Visible    id=input_diskMode
    Select From List By Label    id=input_diskMode    ${create_volume_and_add_rdm_volume_to_vm_data.disk_mode}
    Sleep    10
    Wait Until Element Is Visible    id=input_hba
    Select From List By Label    id=input_hba    ${create_volume_and_add_rdm_volume_to_vm_data.scsi_controller_on_vm._1_to_4_controllers_with_key_=_1000_to_1003}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${create_volume_and_add_rdm_volume_to_vm_data.datastore_to_contain_the_rdm_mapping_file}
    Sleep    10
    Wait Until Element Is Visible    id=input_lunScsiId
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
