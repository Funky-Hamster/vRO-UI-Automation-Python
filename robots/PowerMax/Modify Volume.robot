*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/modify_volumepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify Volume Basic
    [Arguments]    &{modify_volume_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_volume
    Select From List By Label    id=input_volume    ${modify_volume_data.powermax_volume_that_will_be_modified}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeIdentifier
    Input Text    id=input_volumeIdentifier    ${modify_volume_data.user_friendly_name_that_needs_to_be_set_or_unset_on_the_volume}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
