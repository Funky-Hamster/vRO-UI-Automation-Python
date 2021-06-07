from selenium.common.exceptions import TimeoutException
import time
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
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_loading_center_spinner))
        time.sleep(2)
        browser.find_element(*self.workflow_run_button).click()
        time.sleep(6)
        self.explicit_wait.until_not(EC.visibility_of_element_located(self.vro_data_loading_spinner))
        workflow_content = browser.find_elements(*self.workflow_content)[0]
        return HtmlResponse(url=browser.current_url, body=workflow_content.get_attribute("outerHTML"), encoding="utf-8", request=request)