*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/restore_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Restore SRDF Protection Basic
    [Arguments]    &{restore_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${restore_srdf_protection_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${restore_srdf_protection_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${restore_srdf_protection_data.the_storage_group_rdf_group}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${restore_srdf_protection_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.}
    Sleep    10
    Wait Until Element Is Visible    id=input_metroBias
    Select From List By Label    id=input_metroBias    ${restore_srdf_protection_data.metro_bias_flag:_when_the_srdf_mode_is_set_to_active,_this_specifies_to_use_bias}
    Sleep    10
    Wait Until Element Is Visible    id=input_remote
    Select From List By Label    id=input_remote    ${restore_srdf_protection_data.remote_flag:_requests_a_remote_data_copy_flag._when_the_concurrent_link_is_ready,_data_is_copied_to_the_concurrent_srdf_mirror._these_operations_require_the_remote_data_copy_option,_or_the_concurrent_link_to_be_suspended.}
    Sleep    10
    Wait Until Element Is Visible    id=input_full
    Select From List By Label    id=input_full    ${restore_srdf_protection_data.full_flag:_make_the_action_a_full_restore_as_opposed_to_an_incremental_restore}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
