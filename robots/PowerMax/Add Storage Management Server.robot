*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerMax/add_storage_management_serverpo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Add Storage Management Server Basic
    [Arguments]    &{add_storage_management_server_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_name
    Input Text    id=input_name    ${add_storage_management_server_data.unique_user_friendly_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_type
    Select From List By Label    id=input_type    ${add_storage_management_server_data.type_of_the_storage_management_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_hostName
    Input Text    id=input_hostName    ${add_storage_management_server_data.host_name_(fqdn_or_ip_address)_of_the_storage_management_server}
    Sleep    10
    Wait Until Element Is Visible    id=input_port
    Sleep    10
    Wait Until Element Is Visible    id=input_userName
    Input Text    id=input_userName    ${add_storage_management_server_data.user_name}
    Sleep    10
    Wait Until Element Is Visible    id=input_password
    Sleep    10
    Wait Until Element Is Visible    id=input_httpTimeout
    Sleep    10
    Run Keyword If    ${add_storage_management_server_data.do_you_want_to_ignore_certificate_warnings?_if_you_select_yes,_the_storage_management_server_instance_certificate_is_accepted_silently_and_the_certificate_is_added_to_the_trusted_store} == True    Click Element    xpath=//label[@for="input_ignoreCertificateWarnings"]
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}
