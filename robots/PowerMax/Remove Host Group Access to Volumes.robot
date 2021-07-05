*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/remove_host_group_access_to_volumespo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Remove Host Group Access to Volumes Basic
    [Arguments]    &{remove_host_group_access_to_volumes_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_hostGroup
    Select From List By Label    id=input_hostGroup    ${remove_host_group_access_to_volumes_data.host_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${remove_host_group_access_to_volumes_data.storage_group_masked_to_the_host_group}
    Sleep    10
    Run Keyword If    ${remove_host_group_access_to_volumes_data.remove_access_to_all_volumes_in_the_selected_storage_group?} == True    Click Element    xpath=//label[@for="input_removeAllVolumes"]
    Click Element    xpath=//label[contains(text(),"Volumes to be removed")]/parent::div/parent::div//option[text()="${remove_host_group_access_to_volumes_data.volumes_to_be_removed}"]
    Sleep    10
    Run Keyword If    ${remove_host_group_access_to_volumes_data.force_execution_regardless_of_potential_data_unavailability?} == True    Click Element    xpath=//label[@for="input_force"]
    Sleep    10
    Run Keyword If    ${remove_host_group_access_to_volumes_data.if_true,_removing_access_to_all_volumes_from_an_unmasked_storage_group_will_return_success._removing_access_to_volumes_from_a_storage_group_will_be_allowed_even_if_some_or_all_volumes_are_not_part_of_the_storage_group.} == True    Click Element    xpath=//label[@for="input_ignoreIfNoAccess"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
