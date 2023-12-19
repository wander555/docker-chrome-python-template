from DrissionPage import ChromiumPage, ChromiumOptions
from DrissionPage.easy_set import set_headless

set_headless(True)
co = ChromiumOptions()
co.set_argument('--incognito')
co.set_argument('--no-sandbox')
co.set_paths(browser_path=r'/usr/bin/chromium')
co.auto_port(True)

page = ChromiumPage(co)
page.get('http://g1879.gitee.io/DrissionPageDocs')
print(page.title)
page.quit()
