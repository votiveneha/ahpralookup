from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

options = Options()
options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Chrome(options=options)

driver.get("https://www.ahpra.gov.au/Registration/Registers-of-Practitioners.aspx")
time.sleep(2)

driver.find_element(By.ID, "name-reg").send_keys("NMW0001234567")
driver.find_element(By.ID, "search-button").click()
time.sleep(3)

html = driver.page_source
print(html)

driver.quit()