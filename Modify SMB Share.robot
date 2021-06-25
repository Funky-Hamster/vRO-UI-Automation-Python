*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library    ../custom_defined_keywords_common.py
Variables    ../../PageObjects/Create SMB Share/modify_smb_sharepo.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    
@{auth}    root    vRO4Life!

*** Keywords ***
Workflow Modify SMB Share Basic
    [Arguments]    &{modify_smb_share_data}
    Sleep    10
    Click Element    xpath=//a[text()="General"]
    Sleep    10
    Wait Until Element Is Visible    id=input_clusterName
    Select From List By Label    id=input_clusterName    ${modify_smb_share_data.cluster}
    Sleep    10
    Wait Until Element Is Visible    id=input_zone
    Select From List By Label    id=input_zone    ${modify_smb_share_data.access_zone}
    Sleep    10
    Wait Until Element Is Visible    id=input_name
    Select From List By Label    id=input_name    ${modify_smb_share_data.smb_share}
    Sleep    10
    Wait Until Element Is Visible    id=input_smbShareObj
    Select From List By Label    id=input_smbShareObj    ${modify_smb_share_data.smb_share_object}
    Sleep    10
    Wait Until Element Is Visible    id=input_newSmbShareName
    Input Text    id=input_newSmbShareName    ${modify_smb_share_data.name}
    Sleep    10
    Wait Until Element Is Visible    id=input_description
    Input Text    id=input_description    ${modify_smb_share_data.description}
    Sleep    10
    Wait Until Element Is Visible    id=input_path
    Input Text    id=input_path    ${modify_smb_share_data.path}
    Click Element    xpath=//a[text()="Directory ACLs"]
    Sleep    10
    Wait Until Element Is Visible    id=input_dirACL
    Select From List By Label    id=input_dirACL    ${modify_smb_share_data.directory_acls}
    Click Element    xpath=//a[text()="Home directory provisioning"]
    Sleep    10
    Wait Until Element Is Visible    xpath=//label[@for="input_allowVarExp"]
    Click Element    xpath=//label[@for="input_allowVarExp"]
    Sleep    10
    Wait Until Element Is Visible    xpath=//label[@for="input_autoCreateDir"]
    Click Element    xpath=//label[@for="input_autoCreateDir"]
    Click Element    xpath=//a[text()="Continuous Availability"]
    Click Element    xpath=//a[text()="Members"]
    Click Element    xpath=//label[contains(text(),"Read-only users")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_only_users}"]
    Click Element    xpath=//label[contains(text(),"Read-write users")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_write_users}"]
    Click Element    xpath=//label[contains(text(),"Full control users")]/parent::div/parent::div//option[text()="${modify_smb_share_data.full_control_users}"]
    Click Element    xpath=//label[contains(text(),"Root users")]/parent::div/parent::div//option[text()="${modify_smb_share_data.root_users}"]
    Click Element    xpath=//label[contains(text(),"Read-only groups")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_only_groups}"]
    Click Element    xpath=//label[contains(text(),"Read-write groups")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_write_groups}"]
    Click Element    xpath=//label[contains(text(),"Full control groups")]/parent::div/parent::div//option[text()="${modify_smb_share_data.full_control_groups}"]
    Click Element    xpath=//label[contains(text(),"Root groups")]/parent::div/parent::div//option[text()="${modify_smb_share_data.root_groups}"]
    Click Element    xpath=//label[contains(text(),"Read-only well-known SIDs")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_only_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Read-write well-known SIDs")]/parent::div/parent::div//option[text()="${modify_smb_share_data.read_write_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Full control well-known SIDs")]/parent::div/parent::div//option[text()="${modify_smb_share_data.full_control_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Root well-known SIDs")]/parent::div/parent::div//option[text()="${modify_smb_share_data.root_well_known_sids}"]
    Click Element    xpath=//a[text()="File Filter"]
    Sleep    10
    Wait Until Element Is Visible    xpath=//label[@for="input_enableFileFilters"]
    Click Element    xpath=//label[@for="input_enableFileFilters"]
    Sleep    10
    Wait Until Element Is Visible    id=input_fileFilterType
    Select From List By Label    id=input_fileFilterType    ${modify_smb_share_data.file_filter_type}
    Wait Until Element Is Enabled    xpath=//*[@id="fileFilterExtensions"]/div/div[2]/div[1]/input
    Input Text    xpath=//*[@id="fileFilterExtensions"]/div/div[2]/div[1]/input    ${modify_smb_share_data.file_filter_extensions}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}

Validate Workflow Modify SMB Share Basic
    [Arguments]    &{modify_smb_share_data}
    Click Element    xpath=//a[@href ='#/inventory']
    Wait Until Element Is Visible    xpath=//label[text()='Dell EMC Create SMB Share']
    Wait Until Element Is Enabled    xpath=//label[@title="Dell EMC Create SMB Share"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="Dell EMC Create SMB Share"]/parent::button/parent::div/parent::div/button[@type="button"]
    Wait Until Element Is Enabled    xpath=//label[@title="${modify_smb_share_data.cluster}"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="${modify_smb_share_data.cluster}"]/parent::button/parent::div/parent::div/button[@type="button"]
    Wait Until Element Is Enabled    xpath=//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]
    Click Button    xpath=//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]
