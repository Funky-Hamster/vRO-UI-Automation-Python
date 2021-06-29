*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerScale/delete_smb_sharepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    x-isi-ifs-target-type=container    x-isi-ifs-access-control=public_read_write
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Delete SMB Share Basic
    [Arguments]    &{delete_smb_share_data}
    Sleep    10
    Click Element    xpath=//a[text()=""]
    Sleep    10
    Wait Until Element Is Visible    id=input_clusterName
    Select From List By Label    id=input_clusterName    ${delete_smb_share_data.cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_zone
    Select From List By Label    id=input_zone    ${delete_smb_share_data.access_zone}
    Sleep    10
    Wait Until Element Is Visible    id=input_smbShareName
    Select From List By Label    id=input_smbShareName    ${delete_smb_share_data.smb_share_name}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}

Validate Workflow Delete SMB Share Basic
    [Arguments]    &{delete_smb_share_data}
    Click Element    xpath=//a[@href ='#/inventory']
    Wait Until Element Is Visible    xpath=//label[text()='Dell EMC PowerScale']
    Wait Until Element Is Enabled    xpath=//label[@title="Dell EMC PowerScale"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="Dell EMC PowerScale"]/parent::button/parent::div/parent::div/button[@type="button"]
    Wait Until Element Is Enabled    xpath=//label[@title="${delete_smb_share_data.cluster}"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="${delete_smb_share_data.cluster}"]/parent::button/parent::div/parent::div/button[@type="button"]
    Wait Until Element Is Enabled    xpath=//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]
    Wait Until Element Is Enabled    xpath=//label[@title="${delete_smb_share_data.access_zone} : ${delete_smb_share_data.name}"]/parent::button
    Click Button    xpath=//label[@title="${delete_smb_share_data.access_zone} : ${delete_smb_share_data.name}"]/parent::button
    ${description}    Get Text  xpath=//th[text()="description"]/following-sibling::td
    Should Be Equal    ${description}    ${delete_smb_share_data.description}
    ${path}    Get Text  xpath=//th[text()="path"]/following-sibling::td
    Should Be Equal    ${path}    ${delete_smb_share_data.path}
    ${zone}    Get Text  xpath=//th[text()="zone"]/following-sibling::td
    Should Be Equal    ${zone}    ${delete_smb_share_data.access_zone}
    ${name}    Get Text  xpath=//th[text()="name"]/following-sibling::td
    Should Be Equal    ${name}    ${delete_smb_share_data.name}
