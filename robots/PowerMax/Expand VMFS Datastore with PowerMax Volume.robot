*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/expand_vmfs_datastore_with_powermax_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Expand VMFS Datastore with PowerMax Volume Basic
    [Arguments]    &{expand_vmfs_datastore_with_powermax_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_vc
    Select From List By Label    id=input_vc    ${expand_vmfs_datastore_with_powermax_volume_data.vcenter_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_host
    Select From List By Label    id=input_host    ${expand_vmfs_datastore_with_powermax_volume_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastore
    Select From List By Label    id=input_datastore    ${expand_vmfs_datastore_with_powermax_volume_data.datastore}
    Sleep    10
    Wait Until Element Is Visible    id=input_disk
    Select From List By Label    id=input_disk    ${expand_vmfs_datastore_with_powermax_volume_data.disk_to_use}
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityToAdd
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${expand_vmfs_datastore_with_powermax_volume_data.capacity_unit_in_mb/gb/tb}
    Click Element    xpath=//a[text()="Storage Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${expand_vmfs_datastore_with_powermax_volume_data.rdf_group_(applicable_for_srdf_protected_backend_volumes)}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
