*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_vmfs_datastore_for_esxi_host_[deprecated]po.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create VMFS Datastore for ESXi Host [Deprecated] Basic
    [Arguments]    &{create_vmfs_datastore_for_esxi_host_[deprecated]_data}
    Sleep    10
    Click Element    xpath=//a[text()="Datastore Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiHost
    Select From List By Label    id=input_esxiHost    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.datastore_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_datastoreName
    Input Text    id=input_datastoreName    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.datastore_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_capacity
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.capacity_unit_in_cyl/mb/gb/tb}
    Sleep    10
    Wait Until Element Is Visible    id=input_vmfsVersion
    Select From List By Label    id=input_vmfsVersion    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.vmfs_version}
    Click Element    xpath=//a[text()="Storage Information"]
    Sleep    10
    Wait Until Element Is Visible    id=input_storageArray
    Select From List By Label    id=input_storageArray    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.storage_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${create_vmfs_datastore_for_esxi_host_[deprecated]_data.storage_group_where_volume_is_created}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
