*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/set_mode_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Set Mode SRDF Protection Basic
    [Arguments]    &{set_mode_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${set_mode_srdf_protection_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${set_mode_srdf_protection_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${set_mode_srdf_protection_data.the_storage_group_rdf_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_mode
    Select From List By Label    id=input_mode    ${set_mode_srdf_protection_data.mode:_sets_the_srdf_mode_for_one_or_more_srdf_pairs_to_synchronous,_asynchronous,_adaptive_copy_disk_mode_or_adaptive_copy_write_pending_mode.}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${set_mode_srdf_protection_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.}
    Sleep    10
    Wait Until Element Is Visible    id=input_consistent
    Select From List By Label    id=input_consistent    ${set_mode_srdf_protection_data.consistent_flag:_transitions_from_async_to_sync_mode._note:_the_consistent_option_is_only_allowed_with_the_sync_value.}
    Sleep    10
    Run Keyword If    ${set_mode_srdf_protection_data.set_skew?_note:_the_skew_cannot_be_used_with_the_async_value.} == True    Click Element    xpath=//label[@for="input_setSkew"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
