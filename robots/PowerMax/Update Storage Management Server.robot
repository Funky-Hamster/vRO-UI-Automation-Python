*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/update_storage_management_serverpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Update Storage Management Server Basic
    [Arguments]    &{update_storage_management_server_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_managementServer
    Select From List By Label    id=input_managementServer    ${update_storage_management_server_data.management_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_name
    Input Text    id=input_name    ${update_storage_management_server_data.unique_user_friendly_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_port
    Sleep    10
    Wait Until Element Is Visible    id=input_userName
    Input Text    id=input_userName    ${update_storage_management_server_data.user_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_password
    Sleep    10
    Wait Until Element Is Visible    id=input_httpTimeout
    Sleep    10
    Run Keyword If    ${update_storage_management_server_data.do_you_want_to_ignore_certificate_warnings?_if_you_select_yes,_the_storage_management_server_instance_certificate_is_accepted_silently_and_the_certificate_is_added_to_the_trusted_store} == True    Click Element    xpath=//label[@for="input_ignoreCertificateWarnings"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
