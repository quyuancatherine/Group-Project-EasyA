from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import sqlite3
from secret import netid

# This is DEFINITELY NOT SAFE. Don't use this. I will scrape everything.
#
# This file will not work unless you have created a different file called "secret.py" with a dictionary like this:
# netid = {'user':'your netid here',
#	'password':'your netid password here'}

# setup database
db = sqlite3.connect('evals')
c = db.cursor()
c.execute('''CREATE TABLE if not exists evals (
	id INTEGER AUTO_INCREMENT,
	Class TEXT,
	Prof TEXT,
	Quarter TEXT,
	Format TEXT,
	Surveyed INTEGER,
	Enrolled INTEGER,
	Overall REAL,
	Content REAL,
	Contribution REAL,
	Effectiveness REAL,
	Interest REAL,
	Learned REAL,
	Grading REAL)''')


driver = webdriver.Chrome('./chromedriver')
# login
driver.get("https://weblogin.washington.edu")
user = driver.find_element_by_id("weblogin_netid")
user.clear()
#netid is given in separate file.
user.send_keys(netid['user'])
password = driver.find_element_by_id("weblogin_password")
password.clear()
password.send_keys(netid['password'])
user.submit()

for cur in range(ord('a'), ord('z')):
	driver.get("https://www.washington.edu/cec/" + chr(cur) + "-toc.html")
	urls = driver.find_elements_by_tag_name('a')
	cur_urls = map(lambda x: x.get_attribute("href"), urls)
	for url in cur_urls:
		if "/" + chr(cur) + "/" in url:
			driver.get(url)
			enrolled = driver.find_element_by_xpath('//table[1]/caption').text.split("\"")
			data = driver.title.split(u"\xa0\xa0")
			all_medians = map(lambda x: x.text, driver.find_elements_by_tag_name("td")[7::8])
			if len(all_medians) < 7:
				all_medians.append(0.0)
				all_medians.append(0.0)
				all_medians.append(0.0)
			complete_data = (str(data[0]), str(data[1]), str(data[3]), enrolled[0][5], int(enrolled[1]), int(enrolled[3]), float(all_medians[0]), float(all_medians[1]), float(all_medians[2]), float(all_medians[3]), float(all_medians[4]), float(all_medians[5]), float(all_medians[6]))
			c.execute('''INSERT INTO evals VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)''', complete_data)
	db.commit()
db.close()
driver.close()
