*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/failover_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Failover SRDF Protection Basic
    [Arguments]    &{failover_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${failover_srdf_protection_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${failover_srdf_protection_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${failover_srdf_protection_data.the_storage_group_rdf_group}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${failover_srdf_protection_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.}
    Sleep    10
    Wait Until Element Is Visible    id=input_restore
    Select From List By Label    id=input_restore    ${failover_srdf_protection_data.restore_flag:_begins_a_full_copy_from_the_target_to_the_source,_synchronizing_the_dynamic_srdf_pairs._the_dynamic_srdf_device_pairs_swap_personality_and_an_incremental_restore_is_initiated.}
    Sleep    10
    Wait Until Element Is Visible    id=input_immediate
    Select From List By Label    id=input_immediate    ${failover_srdf_protection_data.immediate_flag:_applies_only_to_srdf/asynchronous_capable_devices._causes_command_to_drop_the_srdf/a_session_immediately.}
    Sleep    10
    Wait Until Element Is Visible    id=input_remote
    Select From List By Label    id=input_remote    ${failover_srdf_protection_data.remote_flag:_requests_a_remote_data_copy_flag._when_the_concurrent_link_is_ready,_data_is_copied_to_the_concurrent_srdf_mirror._these_operations_require_the_remote_data_copy_option,_or_the_concurrent_link_to_be_suspended.}
    Sleep    10
    Wait Until Element Is Visible    id=input_establish
    Select From List By Label    id=input_establish    ${failover_srdf_protection_data.establish_flag:_begins_a_device_copy._the_dynamic_srdf_device_pairs_swap_personality_and_an_incremental_establish_is_initiated.}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
