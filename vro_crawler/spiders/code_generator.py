import json

class CodeGenerator:
    def __init__(self):
        f = open('Modify SMB Share.json',)
        # returns JSON object as a dictionary
        self.data = json.load(f)
        # closing file
        f.close()

    # examples
    # powerscale_create_smb_share_po = {
    #     'cluster_id': 'input_clusterName',
    #     'zone_id': 'input_zone',
    #     'name_id': 'input_name',
    #     'description_id': 'input_description',
    #     'path_id': 'input_path',
    #     'createIfNotExist_xpath': '//label[@for="input_createIfNotExist"]',
    #     'directoryACLs_tab_xpath': '//a[text()="Directory ACLs"]',
    #     'directoryACLs_id': 'input_dirACL',
    #     'homeDirectoryProvisioning_tab_xpath': '//a[text()="Home directory provisioning"]',
    #     'allowVarExp_xpath': '//label[@for="input_allowVarExp"]',
    #     'create_home_directories_xpath': '//label[@for="input_autoCreateDir"]',
    #     'continuousAvailability_tab_xpath': '//a[text()="Continuous Availability"]',
    #     'continuousAvailability_xpath': '//label[@for="input_enableContinuousAvailability"]',
    #     'members_xpath': '//a[text()="Members"]',
    #     'file_filter_tab_xpath': '//a[text()="File Filter"]',
    #     'enable_file_filters_xpath': '//label[@for="input_enableFileFilters"]',
    #     'file_filter_type_id': 'input_fileFilterType',
    #     'file_filter_extensions1_xpath': '//*[@id="fileFilterExtensions"]/div/div[2]/div[1]/input',
    #     'file_filter_extensions2_xpath': '//*[@id="fileFilterExtensions"]/div/div[2]/div[2]/input',
    #     'file_filter_extensions_add_xpath': '//clr-icon[@shape="plus-circle"]',
    #     'run_button_id': 'confirm-btn'
    # }

    # powerscale_create_smb_share_inventory_po = {
    #     'cluster_expand_xpath': '//label[@title="' + CLUSTER_CONNECTION_NAME + '"]/parent::button/parent::div/parent::div/button[@type="button"]',
    #     'smb_shares_expand_xpath': '//label[@title="SMB Shares"]/parent::button/parent::div/parent::div/button[@type="button"]',
    #     'smb_share_item_system_xpath': '//label[@title="' + SMB_SHARE_NAME_SYSTEM_INVENTORY + '"]/parent::button',
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


    # def generate_page_object(self):
    #     # TODO change '[0]' to search by name
    #     tabs = self.data['workflows'][0]['content']['tabs']
