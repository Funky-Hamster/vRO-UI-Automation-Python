import json
import re

class CodeGenerator:
    def __init__(self):
        f = open('Modify SMB Share.json')
        # returns JSON object as a dictionary
        self.workflow_data = json.load(f)
        # closing file
        f.close()

        f = open('PowerScale Inventory.json')
        # returns JSON object as a dictionary
        self.inventory_data = json.load(f)
        # closing file
        f.close()

        self.MODIFY_SMB_SHARE_NAME = 'SMB_SHARE_AUTO_Dan'
        self.SMB_SHARE_NAME_SYSTEM_INVENTORY = 'System : ' + self.MODIFY_SMB_SHARE_NAME

    inventory_to_workflow_data_title = {
        'storage': ['cluster', 'unity_storage_system'],
        # 'homeDirectoryProvisioning': {'Auto-create directories': {'Path variables will not be expanded Directories will not be automatically created': 'true', '': ''}},
        'description': 'description',
        'path': 'path',
        'zone': 'access_zone',
        # 'members': 
        'name': 'name',
        'createPermissions': 'directory_acls'
    }

    # examples
    powerscale_create_smb_share_po = {
        'cluster_id': 'input_clusterName',
        'zone_id': 'input_zone',
        'name_id': 'input_name',
        'description_id': 'input_description',
        'path_id': 'input_path',
        'createIfNotExist_xpath': '//label[@for="input_createIfNotExist"]',
        'directoryACLs_tab_xpath': '//a[text()="Directory ACLs"]',
        'directoryACLs_id': 'input_dirACL',      
        'homeDirectoryProvisioning_tab_xpath': '//a[text()="Home directory provisioning"]',
        'allowVarExp_xpath': '//label[@for="input_allowVarExp"]',
        'create_home_directories_xpath': '//label[@for="input_autoCreateDir"]',
        'continuousAvailability_tab_xpath': '//a[text()="Continuous Availability"]',
        'continuousAvailability_xpath': '//label[@for="input_enableContinuousAvailability"]',
        'members_xpath': '//a[text()="Members"]',
        'file_filter_tab_xpath': '//a[text()="File Filter"]',
        'enable_file_filters_xpath': '//label[@for="input_enableFileFilters"]',
        'file_filter_type_id': 'input_fileFilterType',
        'file_filter_extensions1_xpath': '//*[@id="fileFilterExtensions"]/div/div[2]/div[1]/input',
        'file_filter_extensions2_xpath': '//*[@id="fileFilterExtensions"]/div/div[2]/div[2]/input',
        'file_filter_extensions_add_xpath': '//clr-icon[@shape="plus-circle"]',
        'run_button_id': 'confirm-btn'
    }

    # powerscale_create_smb_share_inventory_po = {
    #     'cluster_expand_xpath': '//label[@title="' + CLUSTER_CONNECTION_NAME + '"]/parent::button/parent::div/parent::div/button[@type="button"]',
    #     'smb_shares_expand_xpath': '//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]',
    #     'smb_share_item_system_xpath': '//label[@title="System : SMB_SHARE_AUTO_Dan"]/parent::button',
    #     'smb_share_item_display_name_xpath': '//h4',
    #     'homeDirectoryProvisioning_attribute_xpath': '//th[text()="homeDirectoryProvisioning"]/following-sibling::td',
    #     'fileFilterType_attribute_xpath': '//th[text()="fileFilterType"]/following-sibling::td',
    #     'description_attribute_xpath': '//th[text()="description"]/following-sibling::td',
    #     'fileFilterExtensions_attribute_xpath': '//th[text()="fileFilterExtensions"]/following-sibling::td',
    #     'path_attribute_xpath': '//th[text()="path"]/following-sibling::td',
    #     'zone_attribute_xpath': '//th[text()="zone"]/following-sibling::td',
    #     'continuousAvailability_attribute_xpath': '//th[text()="continuousAvailability"]/following-sibling::td',
    #     'members_attribute_xpath': '//th[text()="members"]/following-sibling::td',
    #     'name_attribute_xpath': '//th[text()="name"]/following-sibling::td',
    #     'fileFilterEnabled_attribute_xpath': '//th[text()="fileFilterEnabled"]/following-sibling::td',
    #     'createPermissions_attribute_xpath': '//th[text()="createPermissions"]/following-sibling::td',
    #     'fullType_attribute_xpath': '//th[text()="@fullType"]/following-sibling::td'
    # }

    # powerscale_create_smb_share_basic = {
    #     'Cluster': CLUSTER_CONNECTION_NAME,
    #     'Access_zone': SYSTEM_ZONE,
    #     'Name': CREATE_SMB_SHARE_NAME,
    #     'Description': CREATE_SMB_SHARE_DESCRIPTION,
    #     'Path': CREATE_SMB_SHARE_SYSTEM_PATH,
    #     'Directory_ACLs': DIRECTORY_ACLS_WINDOWS,
    #     'Read_only_users': READ_ONLY_USERS,
    #     'Read_write_users': READ_WRITE_USERS,
    #     'Full_control_users': FULL_CONTROL_USERS,
    #     'Root_users': ROOT_USERS,
    #     'Read_only_groups': READ_ONLY_GROUPS,
    #     'Read_write_groups': READ_WRITE_GROUPS,
    #     'Full_control_groups': FULL_CONTROL_GROUPS,
    #     'Root_groups': ROOT_GROUPS,
    #     'Read_only_well_known_sids': READ_ONLY_WELL_KNOWN_SIDS,
    #     'Read_write_well_known_sids': READ_WRITE_WELL_KNOWN_SIDS,
    #     'Full_control_well_known_sids': FULL_CONTROL_WELL_KNOWN_SIDS,
    #     'Root_well_known_sids': ROOT_WELL_KNOWN_SIDS,
    #     'File_filter_type': FILE_FILTER_TYPE_ALLOW,
    #     'File_filter_extentions_1': FILE_FILTER_EXTENSIONS_1,
    #     'File_filter_extensions_2': FILE_FILTER_EXTENSIONS_2
    # }

    # powerscale_create_smb_share_basic_inventory = {
    #     'display_name': SMB_SHARE_NAME_SYSTEM_INVENTORY,
    #     'homeDirectoryProvisioning': HOME_DIRECTORY_PROVISIONING_NOT_SELECT_CREATE,
    #     'fileFilterType': FILE_FILTER_TYPE_ALLOW,
    #     'description': CREATE_SMB_SHARE_DESCRIPTION,
    #     #'fileFilterExtensions': '',
    #     'fileFilterExtensions': FILE_FILTER_EXTENSIONS,
    #     'path': CREATE_SMB_SHARE_SYSTEM_PATH,
    #     'zone': SYSTEM_ZONE,
    #     'continuousAvailability': CONTINUOUS_AVAILABILITY_ENABLED,
    #     'members': MEMBERS_BASIC,
    #     'name': CREATE_SMB_SHARE_NAME,
    #     'fileFilterEnabled': 'Enabled',
    #     'createPermissions': CREATE_PERMISSIONS_DEFAULT,
    #     'fullType': SMB_SHARE_FULL_TYPE
    # }


    def generate_page_object(self):
        # TODO change '[0]' to search by name
        workflow_po = dict()
        inventory_po = dict()
        tabs = self.workflow_data['workflows'][0]['content']['tabs']
        for tab in tabs:
            workflow_po[tab['name'].lower().replace(" ", "_") + "_xpath"] = '//a[text()="' + tab['name'] + '"]'
            contents = tab['content']
            for content in contents:
                workflow_po[content['id']] = content['for']
        workflow_po['confirm-btn'] = 'confirm-btn'
        print(workflow_po)
        self.dict_to_json_write_file(workflow_po, "Modify SMB Share Workflow PO")

        inventory_po = dict()

        demos = self.inventory_data[0]['content'][0]['content'][0]['content']
        for demo in demos:
            inventory_po[demo['title'] + '_xpath'] = self.get_inventory_attribute_by_title(demo['title'])
        inventory_po['cluster_expand_xpath'] = self.get_expand_path_by_name('PowerScale244')
        inventory_po['smb_shares_expand_xpath'] = self.get_expand_path_by_name('SMB Shares')
        inventory_po['smb_share_item_system_xpath'] = self.get_expand_path_by_name(self.SMB_SHARE_NAME_SYSTEM_INVENTORY)
        print(inventory_po)
        self.dict_to_json_write_file(inventory_po, "Modify SMB Share Inventory PO")

    def generate_json_to_py(self):
        f = open('Modify SMB Share Workflow PO.json')
        # returns JSON object as a dictionary
        po_data = json.load(f)
        # closing file
        f.close()
        with open('po_test.py', 'w') as file_handle:
            file_handle.write('from Config.PowerScale.property import *\n')
            file_handle.write('\n')
            file_handle.write('powerscale_modify_smb_share_po = ')
            file_handle.write(str(po_data))

        f = open('Modify SMB Share Inventory PO.json')
        # returns JSON object as a dictionary
        po_data = json.load(f)
        # closing file
        f.close()
        with open('po_inventoy_test.py', 'w') as file_handle:
            file_handle.write('from Config.PowerScale.property import *\n')
            file_handle.write('\n')
            file_handle.write('powerscale_modify_smb_share_basic_inventory = ')
            po_data['smb_share_item_system_xpath'] = '&&$$SMB_SHARE_NAME_SYSTEM_INVENTORY&&$$'
            file_handle.write(str(po_data).replace("'&&$$", "").replace("&&$$'", ""))
            
    def generate_config(self):
        workflow_config = dict()
        inventory_config = dict()
        tabs = self.workflow_data['workflows'][0]['content']['tabs']
        for tab in tabs:
            for row in tab['content']:
                workflow_config[row['label'].strip().capitalize().replace("-", "_").replace(" ", "_")] = "$$##" + self.pascal_case_to_snake_case(row['id']).upper().replace("A_C_L", "ACL") + "$$##"
        self.dict_to_json_write_file(workflow_config, "Modify SMB Share Workflow Config")
        demos = self.inventory_data[0]['content'][0]['content'][0]['content']
        for demo in demos:
            inventory_config[demo['title']] = "$$##" + self.pascal_case_to_snake_case(demo['title']).upper() + "$$##"
        self.dict_to_json_write_file(inventory_config, "Modify SMB Share Inventory Config")

    def generate_config_json_to_py(self):
        f = open('Modify SMB Share Workflow Config.json')
        # returns JSON object as a dictionary
        workflow_config_data = json.load(f)
        # closing file
        f.close()
        f = open('Modify SMB Share Inventory Config.json')
        # returns JSON object as a dictionary
        inventory_config_data = json.load(f)
        # closing file
        f.close()
        with open('config.py', 'w') as file_handle:
            file_handle.write('from Config.PowerScale.property import *\n')
            file_handle.write('\n')
            file_handle.write('powerscale_modify_smb_share_workflow_config = ')
            file_handle.write(str(workflow_config_data).replace("'$$##", "").replace("$$##'", ""))
            file_handle.write('\n')
            file_handle.write('powerscale_modify_smb_share_inventory_config = ')
            file_handle.write(str(inventory_config_data).replace("'$$##", "").replace("$$##'", "").replace("@", ""))

    def generate_robot(self, platform: str = 'PowerScale', resource: str = 'SMB Share', workflow: str = 'Modify SMB Share', username: str = 'root', password: str = 'vRO4Life!'):
        # generate workflow robot
        snake_case_workflow = workflow.strip().replace(" ", "_").lower()
        with open(workflow + '.robot', 'w') as file_handle:
            file_handle.write('*** Settings ***\n')
            file_handle.write('Library    SeleniumLibrary    120\n')
            file_handle.write('Library    RequestsLibrary\n')
            file_handle.write('Resource    ../Keywords_common.robot\n')
            file_handle.write('Library    ../custom_defined_keywords_common.py\n')
            file_handle.write('Variables    ../../PageObjects/' + platform + '/' + snake_case_workflow + 'po.py\n')
            file_handle.write('\n')
            file_handle.write('*** Variables ***\n')
            file_handle.write('&{headers}  Content-Type=application/json  Accpet=application/json    ')
            if platform.find('PowerScale') != -1:
                file_handle.write('x-isi-ifs-target-type=container    x-isi-ifs-access-control=public_read_write\n')
            else:
                file_handle.write('\n')
            file_handle.write('@{auth}    ' + username + '    ' + password + '\n')
            file_handle.write('\n')
            file_handle.write('*** Keywords ***\n')
            file_handle.write('Workflow ' + workflow + ' Basic\n')
            # Leave the documentation tag for now, TODO: Add documentation logic
            data = snake_case_workflow + '_data'
            modify_smb_share_data = {'cluster': 'PowerScale199', 'zone': 'System', 'name': 'dan-test'}
            file_handle.write('    [Arguments]    &{' + data + '}\n')
            file_handle.write('    Sleep    10\n')
            # open PO data
            tabs = self.workflow_data['workflows'][0]['content']['tabs']
            # Wait for each element and make selection or input
            for tab in tabs:
                file_handle.write('    Click Element    xpath=' + '//a[text()="' + tab['name'] + '"]\n')
                for row in tab['content']:
                    if (row['for'] != None) & (row['label'].find('non-editable') == -1) & (row['type'] != 'multi-select') & (row['type'] != 'array'):
                        file_handle.write('    Sleep    10\n')
                        if row['type'] != 'checkbox':
                            file_handle.write('    Wait Until Element Is Visible    id=' + row['for'] + '\n')
                        if (row['type'] == 'dropdown') | (row['type'] == 'value-picker'):
                            file_handle.write('    Select From List By Label    ')
                        elif (row['type'] == 'text-field'):
                            file_handle.write('    Input Text    ')
                        elif row['type'] == 'checkbox':
                            file_handle.write('    Wait Until Element Is Visible    xpath=//label[@for="' + row['for'] + '"]\n')
                            file_handle.write('    Click Element    xpath=//label[@for="' + row['for'] + '"]\n')
                            continue
                        else:
                            continue
                        file_handle.write('id=' + row['for'] + '    ${' + data + '.' + row['label'].strip().replace("-", "_").replace(" ", "_").lower() + '}\n')
                    
                    elif (row['type'] == 'multi-select'):
                        file_handle.write('    Click Element    xpath=//label[contains(text(),"' + row['label'].strip() + '")]/parent::div/parent::div//option[text()="${' + data + '.' + row['label'].strip().replace("-", "_").replace(" ", "_").lower() + '}"]\n')
                    elif (row['type'] == 'array'):
                        file_handle.write('    Wait Until Element Is Enabled    xpath=//*[@id="' + row['id'] + '"]/div/div[2]/div[1]/input\n')
                        file_handle.write('    Input Text    xpath=//*[@id="' + row['id'] + '"]/div/div[2]/div[1]/input' + '    ${' + data + '.' + row['label'].strip().replace("-", "_").replace(" ", "_").lower() + '}\n')
            file_handle.write('    No Errors\n')
            file_handle.write('    Click Button    id=${powerscale_create_smb_share_po[\'run_button_id\']}\n')
            file_handle.write('    Wait Until Element Is Visible    xpath=//div[@id=\'wfStatusInfo\']//span\n')
            file_handle.write('    Wait Until Element Does Not Contain    xpath=//div[@id=\'wfStatusInfo\']//span    Running\n')
            file_handle.write('    ${status}    Get Text    xpath=//div[@id=\'wfStatusInfo\']//span\n')
            file_handle.write('    [Return]    ${status}\n')

            # generate validation for the inventory
            plugin_name = 'Dell EMC ' + platform
            file_handle.write('\n')
            file_handle.write('Validate Workflow ' + workflow + ' Basic\n')
            inventory_item = snake_case_workflow + '_inventory_item'
            file_handle.write('    [Arguments]    &{' + data + '}\n')
            file_handle.write('    Click Element    xpath=//a[@href =\'#/inventory\']\n')
            file_handle.write('    Wait Until Element Is Visible    xpath=//label[text()=\'' + plugin_name + '\']' + '\n')
            file_handle.write('    Wait Until Element Is Enabled    xpath=' + self.get_expand_path_by_name(plugin_name) + '\n')
            file_handle.write('    Click Button    xpath=' + self.get_expand_path_by_name(plugin_name) + '\n')

            file_handle.write('    Wait Until Element Is Enabled    xpath=' + self.get_expand_path_by_name('${' + data + '.' + self.find_storage(self.inventory_to_workflow_data_title['storage'], {data}) + '}') + '\n')
            file_handle.write('    Click Button    xpath=' + self.get_expand_path_by_name('${' + data + '.' + self.find_storage(self.inventory_to_workflow_data_title['storage'], {data}) + '}') + '\n')
            file_handle.write('    Wait Until Element Is Enabled    xpath=' + self.get_expand_path_by_name(resource + 's') + '\n')
            file_handle.write('    Click Button    xpath=' + self.get_expand_path_by_name(resource + 's') + '\n')
            # TODO: generate dict data
            file_handle.write('    Wait Until Element Is Enabled    xpath=' + self.get_related_button(self.generate_resource_name(platform, resource, data)) + '\n')
            file_handle.write('    Click Button    xpath=' + self.get_related_button(self.generate_resource_name(platform, resource, data)) + '\n')
            # ${display_name}    Get Text  xpath=${powerscale_create_smb_share_inventory_po['smb_share_item_display_name_xpath']}
            # Should Be Equal    ${display_name}    ${smb_basic_inventory_item.display_name}
            items = self.inventory_data[0]['content'][0]['content'][0]['content']
            for item in items:
                title = item['title']
                if self.inventory_to_workflow_data_title.__contains__(title):
                    file_handle.write('    ${' + title + '}    Get Text  xpath=//th[text()="' + title + '"]/following-sibling::td\n')
                    file_handle.write('    Should Be Equal    ${' + title + '}    ${' + data + '.' + self.inventory_to_workflow_data_title[title] + '}\n')

    def find_storage(self, storage_array, data: dict):
        return 'cluster'
        # print(data)
        # for storage in storage_array:
        #     if data[storage] != None:
        #         return storage

    def generate_resource_name(self, platform: str, resource: str, data_var: str):
        if platform.find('PowerScale') != -1:
            if resource.find('SMB') != -1:
                return '${' + data_var + '.access_zone} : ${' + data_var + '.name}'
        #         return data['zone'] + ' : ' + data['name']
        # return ''

    def dict_to_json_write_file(self, dict_obj: dict, name: str):
        with open(name + '.json', 'w') as f:
            json.dump(dict_obj, f)

    def get_expand_path_by_name(self, name: str):
        return '//label[@title="' + name + '"]/parent::button/parent::div/parent::div/button[@type="button"]'

    def get_related_button(self, name: str):
        return '//label[@title="' + name + '"]/parent::button'

    def get_inventory_attribute_by_title(self, title: str):
        return '//th[text()="' + title + '"]/following-sibling::td'

    def pascal_case_to_snake_case(self, camel_case: str):
        snake_case = re.sub(r"(?P<key>[A-Z])", r"_\g<key>", camel_case)
        return snake_case.lower().strip('_')

    def snake_case_to_pascal_case(self, snake_case: str):
        words = snake_case.split('_')
        return ''.join(word.title() for word in words)