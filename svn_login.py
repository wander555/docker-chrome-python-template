from DrissionPage import WebPage, ChromiumOptions
from DrissionPage.easy_set import raise_when_ele_not_found
import time
import os
import sys

raise_when_ele_not_found(True)


# 创建配置对象（默认从 ini 文件中读取配置）
co = ChromiumOptions()
# 设置不加载图片、静音、隐身模式、无界面模式启动
co.set_no_imgs(True)
co.set_mute(True)
co.set_argument('--incognito')
co.set_argument('--no-sandbox')
co.set_headless(True)
co.set_paths(browser_path=r'\usr\bin\google-chrome')

# 记录开始时间
start_time = time.time()

# 创建页面对象
page = WebPage(driver_or_options=co)
# page = WebPage()

# 访问网址
page.get('')

# page.get_screenshot(path='D:\\Download\\page.png', full_page=True)

try:
    # 定位到账号文本框，获取文本框元素
    page.ele('#account').input('qiang.zhang')
    # 定位到密码文本框并输入密码
    page.ele('@name=password').input('')
    # 点击登录按钮
    page.ele('#submit').click()
    # 等待页面加载
    page.wait.load_start()
except Exception as e:
    print('不需要登录...')

page.get('')


try:
    bug_size_element = page.ele('x://*[@id="bugList"]/tfoot/tr/td/div[2]/strong[1]')
    if bug_size_element:
        bugSize = bug_size_element.text
    else:
        # 处理元素未找到的情况，可以抛出自定义异常或者设置一个默认值
        bugSize = 0
except Exception as e:
    bugSize = 0

print(f"当前bug总数:{bugSize}")


# 记录结束时间
end_time = time.time()
# 计算执行时间
execution_time = end_time - start_time
execution_time = round(execution_time, 2)
print(f"总执行时间: {execution_time} 秒")

os.system("ps -ef | grep chrome | awk '{print $2}' | xargs kill -9")
# page.quit()
sys.exit()

