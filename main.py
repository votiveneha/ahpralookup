from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time
import logging
import sys

# Setup logger
logging.basicConfig(stream=sys.stdout, level=logging.INFO, format='[%(levelname)s] %(asctime)s - %(message)s')
logger = logging.getLogger()

def start_browser():
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    
    logger.info("Starting Chrome browser...")
    driver = webdriver.Chrome(options=chrome_options)
    return driver

def scrape_ahpra():
    driver = start_browser()
    
    try:
        url = "https://www.ahpra.gov.au/Registration/Registers-of-Practitioners.aspx"
        logger.info(f"Navigating to {url}")
        driver.get(url)
        time.sleep(2)
        
        logger.info(f"Page Title: {driver.title}")
        
        logger.info("Done. Closing browser.")
    except Exception as e:
        logger.error(f"Scraping failed: {str(e)}")
    finally:
        driver.quit()

if __name__ == "__main__":
    scrape_ahpra()
