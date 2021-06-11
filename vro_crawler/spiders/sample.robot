*** Settings ***
Library    SeleniumLibrary    120
Library    RequestsLibrary
Resource    ../Keywords_common.robot
Library     ../custom_defined_keywords_common.py
Variables    ../../PageObjects/PowerScale/smb_share_po.py

*** Variables ***
&{headers}  Content-Type=application/json  Accpet=application/json    x-isi-ifs-target-type=container    x-isi-ifs-access-control=public_read_write
@{auth}    root    vRO4Life

*** Keywords ***
Workflow Create SMB Share Basic
    [Documentation]    This is the basic workflow to create a smb share, the path already exists
    [Arguments]    &{smb_basic_data}
    Sleep    10
    Wait Until Element Is Visible    id=${powerscale_create_smb_share_po['cluster_id']}
    Select From List By Label    id=${powerscale_create_smb_share_po['cluster_id']}    ${smb_basic_data.Cluster}
    Wait Until Element Is Visible    id=${powerscale_create_smb_share_po['zone_id']}
    Select From List By Label    id=${powerscale_create_smb_share_po['zone_id']}    ${smb_basic_data.Access_zone}
    Input Text    id=${powerscale_create_smb_share_po['name_id']}    ${smb_basic_data.Name}
    Input Text    id=${powerscale_create_smb_share_po['description_id']}    ${smb_basic_data.Description}
    Input Text    id=${powerscale_create_smb_share_po['path_id']}    ${smb_basic_data.Path}    True
    #Click Element    xpath=${powerscale_create_smb_share_po['createIfNotExist_xpath']}
    Click Element    xpath=${powerscale_create_smb_share_po['directoryACLs_tab_xpath']}
    Wait Until Element Is Visible    xpath=//label[contains(text(),"Directory ACLs")]
    Select From List By Label    id=${powerscale_create_smb_share_po['directoryACLs_id']}    ${smb_basic_data.Directory_ACLs}
    Click Element    xpath=${powerscale_create_smb_share_po['homeDirectoryProvisioning_tab_xpath']}
    Wait Until Page Contains    Allow variable expansion
    Click Element    xpath=${powerscale_create_smb_share_po['allowVarExp_xpath']}
    Wait Until Element Is Visible    xpath=${powerscale_create_smb_share_po['create_home_directories_xpath']}
    Click Element    xpath=${powerscale_create_smb_share_po['create_home_directories_xpath']}
    Click Element    xpath=${powerscale_create_smb_share_po['continuousAvailability_tab_xpath']}
    Wait Until Element Is Visible    xpath=//label[contains(text(),"Continuous Availability")]
    Click Element    xpath=${powerscale_create_smb_share_po['continuousAvailability_xpath']}
    Click Element    xpath=${powerscale_create_smb_share_po['members_xpath']}
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Read-only users")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_only_users}"]
    Click Element    xpath=//label[contains(text(),"Read-only users")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_only_users}"]
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Read-write users")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_write_users}"]
    Click Element    xpath=//label[contains(text(),"Read-write users")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_write_users}"]
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Full control users")]/parent::div/parent::div//option[text()="${smb_basic_data.Full_control_users}"]
    Click Element    xpath=//label[contains(text(),"Full control users")]/parent::div/parent::div//option[text()="${smb_basic_data.Full_control_users}"]
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Root users")]/parent::div/parent::div//option[text()="${smb_basic_data.Root_users}"]
    Click Element    xpath=//label[contains(text(),"Root users")]/parent::div/parent::div//option[text()="${smb_basic_data.Root_users}"]
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Read-only groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_only_groups}"]
    Click Element    xpath=//label[contains(text(),"Read-only groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_only_groups}"]
    Wait Until Element Is Enabled    xpath=//label[contains(text(),"Read-write groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_write_groups}"]
    Click Element    xpath=//label[contains(text(),"Read-write groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_write_groups}"]
    Click Element    xpath=//label[contains(text(),"Full control groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Full_control_groups}"]
    Click Element    xpath=//label[contains(text(),"Root groups")]/parent::div/parent::div//option[text()="${smb_basic_data.Root_groups}"]
    Click Element    xpath=//label[contains(text(),"Read-only well-known SIDs")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_only_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Read-write well-known SIDs")]/parent::div/parent::div//option[text()="${smb_basic_data.Read_write_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Full control well-known SIDs")]/parent::div/parent::div//option[text()="${smb_basic_data.Full_control_well_known_sids}"]
    Click Element    xpath=//label[contains(text(),"Root well-known SIDs")]/parent::div/parent::div//option[text()="${smb_basic_data.Root_well_known_sids}"]
    Click Element    xpath=${powerscale_create_smb_share_po['file_filter_tab_xpath']}
    Click Element    xpath=${powerscale_create_smb_share_po['enable_file_filters_xpath']}
    Wait Until Element Is Visible    id=${powerscale_create_smb_share_po['file_filter_type_id']}
    Select From List By Label    id=${powerscale_create_smb_share_po['file_filter_type_id']}    ${smb_basic_data.File_filter_type}
    Input Text    xpath=${powerscale_create_smb_share_po['file_filter_extensions1_xpath']}    ${smb_basic_data.File_filter_extentions_1}
    Click Element    xpath=${powerscale_create_smb_share_po['file_filter_extensions_add_xpath']}
    Wait Until Element Is Enabled    xpath=${powerscale_create_smb_share_po['file_filter_extensions2_xpath']}
    Input Text    xpath=${powerscale_create_smb_share_po['file_filter_extensions2_xpath']}    ${smb_basic_data.File_filter_extensions_2}
    No Errors
    Click Button    id=${powerscale_create_smb_share_po['run_button_id']}
    Wait Until Element Is Visible    xpath=//div[@id='wfStatusInfo']//span
    Wait Until Element Does Not Contain    xpath=//div[@id='wfStatusInfo']//span    Running
    ${status}    Get Text    xpath=//div[@id='wfStatusInfo']//span
    [Return]    ${status}

Validate Workflow Create SMB Share Basic
    [Documentation]    This is used to validate a basic Create SMB Share
    [Arguments]    &{smb_basic_inventory_item}
    Click Element    xpath=//a[@href ='#/inventory']
    Wait Until Element Is Visible    xpath=//label[text()='Dell EMC PowerScale']
    Wait Until Element Is Enabled    xpath=//label[@title='Dell EMC PowerScale']/parent::button/parent::div/parent::div/button[@type='button']
    Click Button    xpath=//label[@title='Dell EMC PowerScale']/parent::button/parent::div/parent::div/button[@type='button']
    Wait Until Element Is Enabled    xpath=${powerscale_create_smb_share_inventory_po['cluster_expand_xpath']}
    Click Button    xpath=${powerscale_create_smb_share_inventory_po['cluster_expand_xpath']}
    Wait Until Element Is Enabled    xpath=${powerscale_create_smb_share_inventory_po['smb_shares_expand_xpath']}
    Click Button    xpath=${powerscale_create_smb_share_inventory_po['smb_shares_expand_xpath']}
    Wait Until Element Is Enabled    xpath=${powerscale_create_smb_share_inventory_po['smb_share_item_system_xpath']}
    Click Button    xpath=${powerscale_create_smb_share_inventory_po['smb_share_item_system_xpath']}
    Wait Until Element Is Visible    xpath=${powerscale_create_smb_share_inventory_po['smb_share_item_display_name_xpath']}
    ${display_name}    Get Text  xpath=${powerscale_create_smb_share_inventory_po['smb_share_item_display_name_xpath']}
    Should Be Equal    ${display_name}    ${smb_basic_inventory_item.display_name}
    ${homeDirectoryProvisioning}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['homeDirectoryProvisioning_attribute_xpath']}
    Should Be Equal    ${homeDirectoryProvisioning}    ${smb_basic_inventory_item.homeDirectoryProvisioning}
    ${fileFilterType}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['fileFilterType_attribute_xpath']}
    Should Be Equal    ${fileFilterType}    ${smb_basic_inventory_item.fileFilterType}
    ${description}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['description_attribute_xpath']}
    Should Be Equal    ${description}    ${smb_basic_inventory_item.description}
    ${fileFilterExtensions}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['fileFilterExtensions_attribute_xpath']}
    Should Be Equal No Order    ${fileFilterExtensions}    ${smb_basic_inventory_item.fileFilterExtensions}
    ${path}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['path_attribute_xpath']}
    Should Be Equal    ${path}    ${smb_basic_inventory_item.path}
    ${zone}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['zone_attribute_xpath']}
    Should Be Equal    ${zone}    ${smb_basic_inventory_item.zone}
    ${continuousAvailability}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['continuousAvailability_attribute_xpath']}
    Should Be Equal    ${continuousAvailability}    ${smb_basic_inventory_item.continuousAvailability}
    ${members}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['members_attribute_xpath']}
    Should Be Equal No Order    ${members}    ${smb_basic_inventory_item.members}
    ${name}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['name_attribute_xpath']}
    Should Be Equal    ${name}    ${smb_basic_inventory_item.name}
    ${fileFilterEnabled}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['fileFilterEnabled_attribute_xpath']}
    Should Be Equal    ${fileFilterEnabled}    ${smb_basic_inventory_item.fileFilterEnabled}
    ${createPermissions}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['createPermissions_attribute_xpath']}
    Should Be Equal    ${createPermissions}    ${smb_basic_inventory_item.createPermissions}
    ${fullType}    Get Text    xpath=${powerscale_create_smb_share_inventory_po['fullType_attribute_xpath']}
    Should Be Equal    ${fullType}    ${smb_basic_inventory_item.fullType}

Check SMB Share exists
    [Documentation]    This is the get call to check smb share exists on powerscale
    [Arguments]    ${smb_name}    ${smb_zone}
    Create Session    smb_get    https://10.225.1.124:8080    ${headers}    auth=${auth}
    ${response}    GET On Session    smb_get    url=/platform/7/protocols/smb/shares/${smb_name}?zone=${smb_zone}