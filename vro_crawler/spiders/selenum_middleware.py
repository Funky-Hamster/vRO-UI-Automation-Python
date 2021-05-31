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
        self.vro_tree_library_position = (By.XPATH, "//*[contains(text(), ' Library ')]")
        self.vro_tree_workflows_position = (By.XPATH, "//*[contains(text(), ' Workflows ')]")
        self.vro_tree_node = (By.TAG_NAME, "tree-node")

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
        time.sleep(3)
        eles = browser.find_elements(*self.vro_tree_library_position)
        print("DTEST " + str(len(eles)))
        self.library_node = None
        for ele in eles:
            print("DTEST FOUND ONE")
            print(ele)
            if ele.find_element(*self.vro_tree_library_position) != None:
                print("DTEST FOUND A ONE")
                if ele.find_element(*self.vro_tree_workflows_position) != None:
                    print("DTEST FOUND THE REAL ONE")
                    self.library_node = ele
                    # self.library_node.find_element(*self.expand_btn).click()
                    # eles_new = browser.find_elements(*self.vro_tree_workflows_position)
                    # print("DTEST " + str(len(eles_new)))
        return HtmlResponse(url=browser.current_url, body=browser.page_source, encoding="utf-8", request=request)