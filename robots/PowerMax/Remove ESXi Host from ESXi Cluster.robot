*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/remove_esxi_host_from_esxi_clusterpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Remove ESXi Host from ESXi Cluster Basic
    [Arguments]    &{remove_esxi_host_from_esxi_cluster_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${remove_esxi_host_from_esxi_cluster_data.powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiCluster
    Select From List By Label    id=input_esxiCluster    ${remove_esxi_host_from_esxi_cluster_data.esxi_cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_esxiHost
    Select From List By Label    id=input_esxiHost    ${remove_esxi_host_from_esxi_cluster_data.esxi_host}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostGroup
    Select From List By Label    id=input_hostGroup    ${remove_esxi_host_from_esxi_cluster_data.host_group}
    Sleep    10
    Run Keyword If    ${remove_esxi_host_from_esxi_cluster_data.place_host_in_maintenance_mode_automatically_if_needed.
if_set_to_no_then_make_sure_that_the_esxi_host_is_in_maintenance_mode_prior_to_running_the_workflow.} == True    Click Element    xpath=//label[@for="input_placeInMaintenanceMode"]
    Sleep    10
    Run Keyword If    ${remove_esxi_host_from_esxi_cluster_data.force_execution_regardless_of_potential_data_unavailability} == True    Click Element    xpath=//label[@for="input_force"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
