*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/suspend_srdf_protectionpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Suspend SRDF Protection Basic
    [Arguments]    &{suspend_srdf_protection_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${suspend_srdf_protection_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroup
    Select From List By Label    id=input_storageGroup    ${suspend_srdf_protection_data.storage_group}
    Sleep    10
    Wait Until Element Is Visible    id=input_storageGroupRdfGroup
    Select From List By Label    id=input_storageGroupRdfGroup    ${suspend_srdf_protection_data.the_storage_group_rdf_group}
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${suspend_srdf_protection_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.}
    Sleep    10
    Wait Until Element Is Visible    id=input_metroBias
    Select From List By Label    id=input_metroBias    ${suspend_srdf_protection_data.metro_bias_flag:__when_the_srdf_is_set_to_active,_this_specifies_to_move_the_bias_to_the_r2_powermax}
    Sleep    10
    Wait Until Element Is Visible    id=input_immediate
    Select From List By Label    id=input_immediate    ${suspend_srdf_protection_data.immediate_flag:_applies_only_to_srdf/asynchronous_capable_devices._causes_command_to_drop_the_srdf/a_session_immediately.}
    Sleep    10
    Wait Until Element Is Visible    id=input_consistencyExempt
    Select From List By Label    id=input_consistencyExempt    ${suspend_srdf_protection_data.consistency_exempt_flag:__	allows_devices_to_be_suspended_without_affecting_the_state_of_the_srdf/a_session_or_requiring_that_other_devices_in_the_session_be_suspended._used_for_an_srdf_group_supporting_an_active_srdf/a_session.}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
