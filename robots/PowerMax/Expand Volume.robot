*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/expand_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Expand Volume Basic
    [Arguments]    &{expand_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_volume
    Select From List By Label    id=input_volume    ${expand_volume_data.powermax_volume_that_will_be_expanded}
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${expand_volume_data.capacity_unit_in_cyl/mb/gb/tb}
    Sleep    10
    Wait Until Element Is Visible    id=input_newVolumeSize
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${expand_volume_data.rdf_group_(applicable_for_srdf_protected_volumes)}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
