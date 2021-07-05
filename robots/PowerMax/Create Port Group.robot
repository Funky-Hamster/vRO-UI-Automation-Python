*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/create_port_grouppo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Create Port Group Basic
    [Arguments]    &{create_port_group_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_powerMaxArray
    Select From List By Label    id=input_powerMaxArray    ${create_port_group_data.the_powermax_array}
    Sleep    10
    Wait Until Element Is Visible    id=input_name
    Input Text    id=input_name    ${create_port_group_data.port_group_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${create_port_group_data.the_port_type_(fibre,_iscsi)}
    Click Element    xpath=//label[contains(text(),"Ports to add to the port group. Recommend ports in PortGroup be on different director")]/parent::div/parent::div//option[text()="${create_port_group_data.ports_to_add_to_the_port_group._recommend_ports_in_portgroup_be_on_different_director}"]
    Sleep    10
    Run Keyword If    ${create_port_group_data.if_true,_the_workfow_will_return_existing_port_group_which_has_the_provided_ports} == True    Click Element    xpath=//label[@for="input_reuseIfMatchFound"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
