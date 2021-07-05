*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/delete_srdf_pairpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Delete SRDF Pair Basic
    [Arguments]    &{delete_srdf_pair_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${delete_srdf_pair_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfGroup
    Select From List By Label    id=input_rdfGroup    ${delete_srdf_pair_data.rdf_group_on_the_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_rdfPair
    Select From List By Label    id=input_rdfPair    ${delete_srdf_pair_data.rdf_pair_to_be_deleted}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
