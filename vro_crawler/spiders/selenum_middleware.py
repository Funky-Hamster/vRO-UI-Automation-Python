from selenium.common.exceptions import TimeoutException
import time
import json
from scrapy.http.response.html import HtmlResponse
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from scrapy.http.response.text import TextResponse
from selenium.webdriver.remote.webelement import WebElement

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

    def process_request_with_selenium(self, request, browser):
        self.explicit_wait = WebDriverWait(browser, 120)
        browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_page_title))
        browser.find_element(*self.username).send_keys('Administrator@vsphere.local')
        browser.find_element(*self.password).send_keys('Password123!')
        self.explicit_wait.until(EC.visibility_of_element_located(self.login_btn))
        browser.find_element(*self.login_btn).click()
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        browser.get(request.url)
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_dashboard_area))
        self.explicit_wait.until(EC.visibility_of_element_located(self.vro_workflow_item_area))
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        self.explicit_wait.until(EC.visibility_of_element_located(self.tree_view_icon))
        browser.find_element(*self.tree_view_icon).click()
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(5)
        eles = browser.find_elements(*self.vro_tree_node)
        for ele in eles:
            if (ele.text == "Library"):
                ele.find_element(*self.expand_btn).click()
                library_node = ele
                print("DTEST clicked")
        time.sleep(3)
        library_eles = library_node.find_elements(*self.vro_tree_node)
        for ele in library_eles:
            if (ele.text.find("Dell EMC PowerScale") != -1):
                ele.find_element(*self.expand_btn).click()
                powerscale_node = ele
        time.sleep(3)
        powerscale_eles = powerscale_node.find_elements(*self.vro_tree_node)
        workflow_name = "test"
        for ele in powerscale_eles:
            print(ele.text)
            ele.find_element(*self.expand_btn).click()
            time.sleep(2)
            y_node = ele
            y_eles = y_node.find_elements(*self.vro_tree_node)
            for y_ele in y_eles:
                print(" " + y_ele.text)
                y_ele.find_element(*self.treenode_link).click()
                time.sleep(0.5)
                chosen_workflow_node = y_ele
                workflow_name = chosen_workflow_node.text
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(2)
        browser.find_element(*self.workflow_run_button).click()
        time.sleep(8)
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_data_loading_spinner))
        workflow_content = browser.find_elements(*self.workflow_content)[0]
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
                                page_array.append({"label": label.get_attribute("textContent"), "id":  cf_potential.get_attribute("id"), "type": cf_potential.tag_name[3:]})
                                break
                        break
            workflow_content_struct["tabs"].append({"name": tabs[i].text, "content": page_array})
        print(workflow_content_struct)
        workflow_struct = dict()
        workflow_struct["workflows"] = []
        workflow_struct["workflows"].append({"name": workflow_name, "content": workflow_content_struct})
        self.dict_to_json_write_file(workflow_struct, workflow_name)
        return HtmlResponse(url=browser.current_url, body=workflow_content.get_attribute("outerHTML"), encoding="utf-8", request=request)

    def dict_to_json_write_file(self, dict, name):
        with open(name + '.json', 'w') as f:
            json.dump(dict, f)
