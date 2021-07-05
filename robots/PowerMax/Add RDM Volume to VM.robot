*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/add_rdm_volume_to_vmpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Add RDM Volume to VM Basic
    [Arguments]    &{add_rdm_volume_to_vm_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_vm
    Select From List By Label    id=input_vm    ${add_rdm_volume_to_vm_data.virtual_machine}
    Sleep    10
    Wait Until Element Is Visible    id=input_lunIdentifier
    Select From List By Label    id=input_lunIdentifier    ${add_rdm_volume_to_vm_data.lun_identifier}
    Sleep    10
    Wait Until Element Is Visible    id=input_compatibilityMode
    Select From List By Label    id=input_compatibilityMode    ${add_rdm_volume_to_vm_data.compatibility_mode
(physicalmode:_array_snapshot,_virtualmode:_vmware_snapshot)}
    Sleep    10
    Wait Until Element Is Visible    id=input_diskMode
    Select From List By Label    id=input_diskMode    ${add_rdm_volume_to_vm_data.disk_mode
(dependent:_included_in_snapshot,_persistent:_normal,_nonpersistent:_writes_discard_on_vm_power_off)}
    Sleep    10
    Wait Until Element Is Visible    id=input_hba
    Select From List By Label    id=input_hba    ${add_rdm_volume_to_vm_data.name_of_hba_on_vm}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${add_rdm_volume_to_vm_data.datastore_to_contain_the_rdm_mapping_file}
    Sleep    10
    Wait Until Element Is Visible    id=input_lunScsiId
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
