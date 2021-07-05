*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_srdf_pairspo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create SRDF Pairs Basic
    [Arguments]    &{create_srdf_pairs_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_srdf_pairs_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${create_srdf_pairs_data.rdf_group_on_the_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_replicationMode
    Select From List By Label    id=input_replicationMode    ${create_srdf_pairs_data.srdf_replication_mode}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfType
    Select From List By Label    id=input_rdfType    ${create_srdf_pairs_data.rdf_type}
    Sleep    10
    Run Keyword If    ${create_srdf_pairs_data.new_volume_pairs?} == True    Click Element    xpath=//label[@for="input_newVolumePairs"]
    Sleep    10
    Wait Until Element Is Visible    id=input_numberOfPairs
    Sleep    10
    Wait Until Element Is Visible    id=input_capacityUnit
    Select From List By Label    id=input_capacityUnit    ${create_srdf_pairs_data.capacity_unit_in_cyl/mb/gb/tb}
    Sleep    10
    Wait Until Element Is Visible    id=input_volumeSize
    Click Element    xpath=//a[text()="Advanced Options"]
    Sleep    10
    Wait Until Element Is Visible    id=input_invalidateR1
    Select From List By Label    id=input_invalidateR1    ${create_srdf_pairs_data.invalidate_r1_flag:_invalidate_the_r1_volume_as_part_of_the_pair_creation}
    Sleep    10
    Wait Until Element Is Visible    id=input_invalidateR2
    Select From List By Label    id=input_invalidateR2    ${create_srdf_pairs_data.invalidate_r2_flag:_invalidate_the_r2_volume_as_part_of_the_pair_creation}
    Sleep    10
    Wait Until Element Is Visible    id=input_establish
    Select From List By Label    id=input_establish    ${create_srdf_pairs_data.establish_flag:_perform_an_srdf_esablish_after_the_pairs_are_created}
    Sleep    10
    Wait Until Element Is Visible    id=input_format
    Select From List By Label    id=input_format    ${create_srdf_pairs_data.format_flag:_no_data_synchronization_is_done_between_source_and_target_dynamic_srdf_pairs_after_all_tracks_are_cleared_on_what_will_become_the_r1_and_r2_side}
    Sleep    10
    Wait Until Element Is Visible    id=input_exempt
    Select From List By Label    id=input_exempt    ${create_srdf_pairs_data.exempt_flag:_allows_volumes_to_be_added,_removed,_or_suspended_without_affecting_the_state_of_the_srdf/a_or_srdf/metro_session_or_requiring_that_other_volumes_in_the_session_be_suspended._used_for_an_srdf_group_supporting_an_active_srdf/a_session_or_an_active_srdf/metro_session}
    Sleep    10
    Wait Until Element Is Visible    id=input_metroBias
    Select From List By Label    id=input_metroBias    ${create_srdf_pairs_data.metro_bias_flag:_when_rdf_mode_is_set_to_active,_this_flag_specifies_to_use_bias_when_creating_an_srdf_metro_pair._if_set_to_false,_witness_will_be_used.}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
