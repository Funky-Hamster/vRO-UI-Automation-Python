import scrapy
from vro_crawler.spiders.vsphere_operations import VSphereOperations
from vro_crawler.spiders.selenum_middleware import SeleniumMiddleware
from selenium import webdriver
import time

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    def __init__(self):
        options = webdriver.ChromeOptions()
        options.add_argument('ignore-certificate-errors')
        self.browser = webdriver.Chrome(executable_path = 'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe', chrome_options=options)
        self.browser.set_page_load_timeout(30)

    def start_requests(self):
        vshere_obj = VSphereOperations()
        # session = vshere_obj.vsphere_login('10.225.6.65', 'Administrator@vsphere.local', 'Password123!')
        url = 'https://vpi163.pie.lab.emc.com/orchestration-ui/#/workflow?query=@tags:Dell_EMC'
        request = scrapy.Request(url=url)
        selenium_middleware_obj = SeleniumMiddleware()
        response = selenium_middleware_obj.process_request_with_selenium(request, self.browser)
        self.parse(response)
        # yield request

    def parse(self, response):
        page = 'daniel-test'
        filename = f'quotes-{page}.html'
        with open(filename, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {filename}')