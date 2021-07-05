from selenium.common.exceptions import TimeoutException
import time
import json
from scrapy.http.response.html import HtmlResponse
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from scrapy.http.response.text import TextResponse
from selenium.webdriver.remote.webelement import WebElement
from selenium import webdriver

class SeleniumMiddleware(object):
    def __init__(self):
        self.login_page_title = (By.ID, "titleVmware")
        self.username = (By.ID, "username")
        self.password = (By.ID, "password")
        self.login_btn = (By.ID, "submit")
        self.expand_btn = (By.CLASS_NAME, "clr-treenode-caret-icon")
        self.tree_view_icon = (By.ID, "treeViewIcon")
        self.vro_dashboard_area = (By.XPATH, "//div[@class='dash-area']")
        self.vro_workflow_item_area = (By.XPATH, "//div[@class='card-title dont-break-out']")
        self.vro_loading_center_spinner = (By.XPATH, "//div[@class='center-spinner']")
        self.vro_inventory_loading_spinner = (By.XPATH, "//div[@class='clr-treenode-spinner']")
        self.vro_tree_library_position = (By.XPATH, "//*[contains(text(), 'Library')]")
        self.vro_tree_workflows_position = (By.XPATH, "//*[contains(text(), ' Workflows ')]")
        self.vro_tree_node = (By.TAG_NAME, "tree-node")
        self.vro_clr_icon = (By.TAG_NAME, "clr-icon")
        self.treenode_link = (By.CLASS_NAME, "clr-treenode-link")
        self.workflow_run_button = (By.ID, "wfEditorBtnRun")
        self.workflow_content = (By.TAG_NAME, "cf-renderer-main")
        self.vro_data_loading_spinner = (By.XPATH, "//div[@class='spinner-inline']")
        self.vro_ul = (By.TAG_NAME, "ul")
        self.vro_li = (By.TAG_NAME, "li")
        self.vro_tab_content = (By.CLASS_NAME, "tab-content")
        self.vro_ng_star_class = (By.CLASS_NAME, "ng-star-inserted")
        self.vro_tab_page = (By.TAG_NAME, "cf-grid-stack-holder")
        self.vro_section = (By.TAG_NAME, "cf-section")
        self.vro_section_dropdown = (By.TAG_NAME, "cf-dropdown")
        self.vro_section_textfield = (By.TAG_NAME, "cf-textfield")
        self.vro_section_datagrid = (By.TAG_NAME, "cf-datagrid")
        self.vro_section_label = (By.TAG_NAME, "label")
        self.vro_section_select = (By.TAG_NAME, "select")
        self.vro_section_select_option = (By.TAG_NAME, "option")

        # inventory part
        self.vro_inventory_node_class = (By.XPATH, "//div[@class='clr-tree-node-content-container']")
        self.inventory_tree_id = (By.ID, "tree")
        self.inventory_tree_node_tag = (By.TAG_NAME, "clr-tree-node")
        self.button_tag = (By.TAG_NAME, "button")
        self.tbody_tag = (By.TAG_NAME, "tbody")
        self.tr_tag = (By.TAG_NAME, "tr")
        self.th_tag = (By.TAG_NAME, "th")
        self.td_tag = (By.TAG_NAME, "td")

        self.browser: webdriver

    def fetch_workflows(self, request, browser: webdriver, platform='PowerStore'):
        self.explicit_wait = WebDriverWait(browser, 120)
        self.browser = browser
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_page_title))
        self.browser.find_element(*self.username).send_keys('Administrator@vsphere.local')
        self.browser.find_element(*self.password).send_keys('Password123!')
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_btn))
        self.browser.find_element(*self.login_btn).click()
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_workflow_item_area))
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        self.explicit_wait.until(EC.visibility_of_element_located(self.tree_view_icon))
        self.browser.find_element(*self.tree_view_icon).click()
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(10)
        eles = self.browser.find_elements(*self.vro_tree_node)
        for ele in eles:
            if (ele.text == "Library"):
                ele.find_element(*self.expand_btn).click()
                library_node = ele
        time.sleep(3)
        # root node of the plugin
        plugin_root_node = None
        library_eles = library_node.find_elements(*self.vro_tree_node)
        for ele in library_eles:
            if (ele.text.find("Dell EMC " + platform) != -1):
                ele.find_element(*self.expand_btn).click()
                plugin_root_node = ele
        time.sleep(3)
        plugin_eles = plugin_root_node.find_elements(*self.vro_tree_node)
        workflow_name = "test"
        workflow_struct = dict()
        workflow_struct["workflows"] = []
        for ele in plugin_eles:
            print(ele.text)
            ele.find_element(*self.expand_btn).click()
            time.sleep(2)
            y_node = ele
            y_eles = y_node.find_elements(*self.vro_tree_node)
            for y_ele in y_eles:
                print(" " + y_ele.text)
                # click workflow
                y_ele.find_element(*self.treenode_link).click()
                time.sleep(0.5)
                chosen_workflow_node = y_ele
                # fetch workflow
                workflow_name = chosen_workflow_node.text
                if workflow_name.find('List') != -1:
                    continue
                if workflow_name.find('Clusters') != -1:
                    continue
                self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
                time.sleep(2)
                self.browser.find_element(*self.workflow_run_button).click()
                time.sleep(8)
                self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_data_loading_spinner))
                workflow_content = self.browser.find_elements(*self.workflow_content)[0]
                tabs = workflow_content.find_elements(*self.vro_ul)[0].find_elements(*self.vro_li)
                tab_pages = workflow_content.find_elements(*self.vro_tab_page)
                workflow_content_struct = dict()
                workflow_content_struct["tabs"] = []
                for i in range(len(tabs)):
                    page_array = []
                    page_sections = tab_pages[i].find_elements(*self.vro_section)
                    for section in page_sections:
                        cf_potentials = section.find_elements(*self.vro_ng_star_class)
                        for cf_potential in cf_potentials:
                            if (cf_potential.tag_name != "cf-section") & (cf_potential.tag_name.find("cf-") != -1):
                                labels = cf_potential.find_elements(*self.vro_section_label)
                                for label in labels:
                                    if label.get_attribute("textContent") != "":
                                        page_array_data = {"label": label.get_attribute("textContent"), "id":  cf_potential.get_attribute("id"), "for": label.get_attribute("for"), "type": cf_potential.tag_name[3:]}
                                        if cf_potential.get_attribute("hidden") != None:
                                            page_array_data['hidden'] = True
                                        else:
                                            page_array_data['hidden'] = False
                                        page_array.append(page_array_data)
                                        break
                                break
                    workflow_content_struct["tabs"].append({"name": tabs[i].text, "content": page_array})
                print(workflow_content_struct)
                workflow_struct["workflows"].append({"name": workflow_name, "content": workflow_content_struct})
        self.dict_to_json_write_file(workflow_struct, platform + ' Workflows')
        return HtmlResponse(url=self.browser.current_url, body=workflow_content.get_attribute("outerHTML"), encoding="utf-8", request=request)

    def fetch_workflows_in_tree(self, request, browser: webdriver, platform='PowerStore'):
        self.explicit_wait = WebDriverWait(browser, 120)
        self.browser = browser
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_page_title))
        self.browser.find_element(*self.username).send_keys('Administrator@vsphere.local')
        self.browser.find_element(*self.password).send_keys('Password123!')
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_btn))
        self.browser.find_element(*self.login_btn).click()
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_workflow_item_area))
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        self.explicit_wait.until(EC.visibility_of_element_located(self.tree_view_icon))
        self.browser.find_element(*self.tree_view_icon).click()
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(10)
        eles = self.browser.find_elements(*self.vro_tree_node)
        for ele in eles:
            if (ele.text == "Library"):
                ele.find_element(*self.expand_btn).click()
                library_node = ele
        time.sleep(3)
        # root node of the plugin
        plugin_root_node = None
        library_eles = library_node.find_elements(*self.vro_tree_node)
        for ele in library_eles:
            if (ele.text.find("Dell EMC " + platform) != -1):
                ele.find_element(*self.expand_btn).click()
                plugin_root_node = ele
        time.sleep(3)
        workflow_name = "test"
        workflow_struct = dict()
        workflow_struct["workflows"] = []
        self.preorder(tree_node=plugin_root_node, workflow_struct=workflow_struct)
        self.dict_to_json_write_file(workflow_struct, platform + ' Workflows')
        workflow_content = self.browser.find_elements(*self.workflow_content)[0]
        return HtmlResponse(url=self.browser.current_url, body=workflow_content.get_attribute("outerHTML"), encoding="utf-8", request=request)

        

    def preorder(self, tree_node: WebElement, workflow_struct: dict):
        next_arr = tree_node.find_elements(*self.vro_tree_node)
        if len(next_arr) == 0:
            print('DTEST ' + tree_node.text)
            return
        print(next_arr)
        for node in next_arr:
            shape = node.find_elements(*self.vro_clr_icon)[0].get_attribute('shape')
            if shape == 'organization':
                print(node.text)
                # if node.text.find('Provision Volumes') != -1:
                #     continue
                self.click_workflow(tree_node=node, workflow_struct=workflow_struct)
            # the first clr_icon with expand option may not be folder shape
            elif (shape == 'folder') | (shape == 'caret'):
                # expand
                node.find_element(*self.expand_btn).click()
                time.sleep(2)
                self.preorder(node, workflow_struct)
        return
    
    def click_workflow(self, tree_node: WebElement, workflow_struct: dict):
        chosen_workflow_node = tree_node
        # fetch workflow
        workflow_name = chosen_workflow_node.text
        if workflow_name.find('List') != -1:
            return
        # if workflow_name.find('Provision Volumes') != -1:
        #     return
        tree_node.find_element(*self.treenode_link).click()
        time.sleep(0.5)
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(2)
        self.browser.find_element(*self.workflow_run_button).click()
        time.sleep(8)
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_data_loading_spinner))
        workflow_content = self.browser.find_elements(*self.workflow_content)[0]
        tabs = workflow_content.find_elements(*self.vro_ul)[0].find_elements(*self.vro_li)
        tab_pages = workflow_content.find_elements(*self.vro_tab_page)
        workflow_content_struct = dict()
        workflow_content_struct["tabs"] = []
        for i in range(len(tabs)):
            page_array = []
            page_sections = tab_pages[i].find_elements(*self.vro_section)
            for section in page_sections:
                cf_potentials = section.find_elements(*self.vro_ng_star_class)
                for cf_potential in cf_potentials:
                    if (cf_potential.tag_name != "cf-section") & (cf_potential.tag_name.find("cf-") != -1):
                        labels = cf_potential.find_elements(*self.vro_section_label)
                        for label in labels:
                            if label.get_attribute("textContent") != "":
                                page_array_data = {"label": label.get_attribute("textContent"), "id":  cf_potential.get_attribute("id"), "for": label.get_attribute("for"), "type": cf_potential.tag_name[3:]}
                                if cf_potential.get_attribute("hidden") != None:
                                    page_array_data['hidden'] = True
                                else:
                                    page_array_data['hidden'] = False
                                page_array.append(page_array_data)
                                break
                        break
            workflow_content_struct["tabs"].append({"name": tabs[i].text, "content": page_array})
        print(workflow_content_struct)
        workflow_struct["workflows"].append({"name": workflow_name, "content": workflow_content_struct})



    def dict_to_json_write_file(self, dict, name):
        with open(name + '.json', 'w') as f:
            json.dump(dict, f)

    def fetch_inventory(self, request, browser: webdriver, workflow='PowerScale'):
        self.browser = browser
        self.explicit_wait = WebDriverWait(self.browser, 120)
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_page_title))
        self.browser.find_element(*self.username).send_keys('Administrator@vsphere.local')
        self.browser.find_element(*self.password).send_keys('Password123!')
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_btn))
        self.browser.find_element(*self.login_btn).click()
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_inventory_node_class))
        time.sleep(3)
        # # expanding
        eles = self.browser.find_element(*self.inventory_tree_id).find_elements(*self.inventory_tree_node_tag)
        inventories = []
        plugin_name = "test"
        for ele in eles:
            if (ele.text.find(workflow) != -1):
                ele.find_element(*self.expand_btn).click()
                self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_inventory_loading_spinner))
                powerscale_node = ele
                plugin_name = ele.text
        time.sleep(2)
        cluster_eles = powerscale_node.find_elements(*self.inventory_tree_node_tag)
        clusters = []
        for ele in cluster_eles:
            cluster_obj = dict()
            self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_inventory_loading_spinner))
            ele.find_element(*self.expand_btn).click()
            self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_inventory_loading_spinner))
            time.sleep(1)
            resources = ele.find_elements(*self.inventory_tree_node_tag)
            for resource in resources:
                if (resource.text.find("SMB Shares") != -1):
                    resource.find_element(*self.expand_btn).click()
                    time.sleep(10)
                    self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_inventory_loading_spinner))
                    smbs = resource.find_elements(*self.inventory_tree_node_tag)
                    smbs_dict = []
                    for smb in smbs:
                        # print(smb.text)
                        smb.find_element(*self.treenode_link).click()
                        time.sleep(0.5)
                        tbody = self.browser.find_elements(*self.tbody_tag)[0]
                        trs = tbody.find_elements(*self.tr_tag)
                        smb_dict = []
                        for tr in trs:
                            # print(" " + tr.find_elements(*self.th_tag)[0].text + " " + tr.find_elements(*self.td_tag)[0].text)
                            smb_dict.append({"title": tr.find_elements(*self.th_tag)[0].text, "value": tr.find_elements(*self.td_tag)[0].text})
                        smbs_dict.append({"name": smb.text, "content": smb_dict})
            cluster_dict = dict()
            cluster_dict = {"name": ele.text.split("\n")[0], "content": [{"name": "SMB Shares", "content": smbs_dict}]}
            clusters.append(cluster_dict)
        print(str(clusters))
        self.dict_to_json_write_file(clusters, "PowerScale Inventory")
        return HtmlResponse(url=self.browser.current_url, body=powerscale_node.get_attribute("outerHTML"), encoding="utf-8", request=request)
