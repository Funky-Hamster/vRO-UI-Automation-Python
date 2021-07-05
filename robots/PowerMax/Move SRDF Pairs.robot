*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/move_srdf_pairspo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Move SRDF Pairs Basic
    [Arguments]    &{move_srdf_pairs_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${move_srdf_pairs_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${move_srdf_pairs_data.the_rdf_group_on_the_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_targetRdfGroup
    Select From List By Label    id=input_targetRdfGroup    ${move_srdf_pairs_data.the_target_rdf_group_that_the_pairs_will_be_moved_to}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfPairsToMove
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_halfMove
    Select From List By Label    id=input_halfMove    ${move_srdf_pairs_data.half_move_flag:_moves_one_side_of_the_dynamic_srdf_pair_from_one_srdf_group_to_another_srdf_group.}
    Sleep    10
    Wait Until Element Is Visible    id=input_bypass
    Select From List By Label    id=input_bypass    ${move_srdf_pairs_data.bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays}
    Sleep    10
    Wait Until Element Is Visible    id=input_exempt
    Select From List By Label    id=input_exempt    ${move_srdf_pairs_data.exempt_flag:__allows_volumes_to_be_added,_removed,_or_suspended_without_affecting_the_state_of_the_srdf/a_or_srdf/metro_session_or_requiring_that_other_volumes_in_the_session_be_suspended._used_for_an_srdf_group_supporting_an_active_srdf/a_session_or_an_active_srdf/metro_session}
    Sleep    10
    Wait Until Element Is Visible    id=input_keepR1
    Select From List By Label    id=input_keepR1    ${move_srdf_pairs_data.keep_r1_flag:_sets_the_winner_side_of_the_srdf/metro_group_to_the_r1_or_the_r2_side,_as_specified._this_option_can_be_used_when_moving_volumes_out_of_the_srdf/metro_group_but_not_when_moving_volumes_into_the_group.}
    Sleep    10
    Wait Until Element Is Visible    id=input_keepR2
    Select From List By Label    id=input_keepR2    ${move_srdf_pairs_data.keep_r2_flag:_sets_the_winner_side_of_the_srdf/metro_group_to_the_r1_or_the_r2_side,_as_specified._this_option_can_be_used_when_moving_volumes_out_of_the_srdf/metro_group_but_not_when_moving_volumes_into_the_group.}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
