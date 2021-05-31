from selenium import webdriver
from scrapy.http.response.html import HtmlResponse
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement

class TranverseTreeView:
    def __init__(self):
        options = webdriver.ChromeOptions()
        options.add_argument('ignore-certificate-errors')
        self.browser = webdriver.Chrome(executable_path = 'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe', chrome_options=options)
        self.browser.set_page_load_timeout(30)
        self.tree_node = WebElement()
        self.tree_stack = []
    
    def next(self):
        # Find the first next node
        self.tree_node.find_elements_by_tag_name("tree-node")
        self.tree_node.find_element_by_id

    def pop(self):
        self.tree_node = self.tree_stack.pop()

    def push(self, element):
        self.tree_stack = self.tree_stack.append(element)

    def isNull(self):
        if self.tree_node.next().length() == 0:
            return True
        return False
