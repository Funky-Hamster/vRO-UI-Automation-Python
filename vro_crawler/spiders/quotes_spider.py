import scrapy
from vro_crawler.spiders.vsphere_operations import VSphereOperations
from vro_crawler.spiders.selenum_middleware import SeleniumMiddleware
from vro_crawler.spiders.code_generator import CodeGenerator
from selenium import webdriver
import time

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    def __init__(self):
        options = webdriver.ChromeOptions()
        options.add_argument('ignore-certificate-errors')
        self.browser = webdriver.Chrome(executable_path = 'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe', chrome_options=options)
        self.browser.set_page_load_timeout(30)

    '''def start_requests(self):
        vshere_obj = VSphereOperations()
        # session = vshere_obj.vsphere_login('10.225.6.65', 'Administrator@vsphere.local', 'Password123!')
        url = 'https://vpi163.pie.lab.emc.com/orchestration-ui/#/workflow?query=@tags:Dell_EMC'
        request = scrapy.Request(url=url)
        selenium_middleware_obj = SeleniumMiddleware()
        # save the fetching step for POC
        #response = selenium_middleware_obj.fetch_workflows(request, self.browser)
        # fetch the data in the inventory
        url = 'https://vpi163.pie.lab.emc.com/orchestration-ui/#/inventory'
        request = scrapy.Request(url=url)
        response = selenium_middleware_obj.fetch_inventory(request, self.browser)
        # code_generator_obj = CodeGenerator()
        self.parse(response)

        # yield request'''
    def start_requests(self):
        code_generator_obj = CodeGenerator()
        # code_generator_obj.generate_page_object()
        code_generator_obj.generate_config_json_to_py()

    def parse(self, response):
        page = 'daniel-test'
        filename = f'quotes-{page}.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')