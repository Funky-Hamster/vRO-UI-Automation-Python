*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_volumespo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Volumes Basic
    [Arguments]    &{create_volumes_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_volumes_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${create_volumes_data.storage_group_where_the_volumes_will_be_added_to}
    Sleep    10
    Wait Until Element Is Visible    id=input_numberOfVolumes
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${create_volumes_data.capacity_unit_in_cyl/mb/gb/tb}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSize
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeIdentifier
    Input Text    id=input_volumeIdentifier    ${create_volumes_data.user_friendly_names_for_the_volumes_to_be_created}
    Click Element    xpath=//a[text()="SRDF Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_remoteArray1
    Select From List By Label    id=input_remoteArray1    ${create_volumes_data.remote_powermax_array_1}
    Click Element    xpath=//label[contains(text(),"Remote PowerMax array 1 storage group names")]/parent::div/parent::div//option[text()="${create_volumes_data.remote_powermax_array_1_storage_group_names}"]
    Sleep    10
    Wait Until Element Is Visible    id=input_remoteArray2
    Select From List By Label    id=input_remoteArray2    ${create_volumes_data.remote_powermax_array_2}
    Click Element    xpath=//label[contains(text(),"Remote PowerMax array 2 storage group names")]/parent::div/parent::div//option[text()="${create_volumes_data.remote_powermax_array_2_storage_group_names}"]
    Sleep    10
    Wait Until Element Is Visible    id=input_srdfForce
    Select From List By Label    id=input_srdfForce    ${create_volumes_data.srdf_force_flag}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
