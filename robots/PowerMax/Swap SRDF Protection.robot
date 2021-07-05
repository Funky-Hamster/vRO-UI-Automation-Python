*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/swap_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Swap SRDF Protection Basic
    [Arguments]    &{swap_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${swap_srdf_protection_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${swap_srdf_protection_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${swap_srdf_protection_data.the_storage_group_rdf_group}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${swap_srdf_protection_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.}
    Sleep    10
    Wait Until Element Is Visible    id=input_halfSwap
    Select From List By Label    id=input_halfSwap    ${swap_srdf_protection_data.halfswap_flag:_swaps_the_srdf_personality_of_one_half_of_the_designated_dynamic_srdf_pair._source_r1_devices_become_target_r2_devices,_and_target_r2_devices_become_source_r1_devices.}
    Sleep    10
    Wait Until Element Is Visible    id=input_refreshR1
    Select From List By Label    id=input_refreshR1    ${swap_srdf_protection_data.refresh_r1:_marks_the_source_(r1)_devices_to_refresh_from_the_remote_mirror.}
    Sleep    10
    Wait Until Element Is Visible    id=input_refreshR2
    Select From List By Label    id=input_refreshR2    ${swap_srdf_protection_data.refresh_r2:_marks_the_target_(r2)_devices_to_refresh_from_the_remote_mirror.}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
