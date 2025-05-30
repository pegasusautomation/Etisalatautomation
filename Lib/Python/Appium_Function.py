from robot.libraries.BuiltIn import BuiltIn
#from AppiumLibrary.keywords import _ApplicationManagementKeywords
#from AppiumLibrary.keywords._applicationmanagement import *
import yaml

import subprocess, os, time


def execute_adb_shell(command, *args):
    appiumlib = BuiltIn().get_library_instance('appiumlibrary')
    currdriver = appiumlib._current_application()
    return currdriver.execute_script('mobile: shell', {
        'command': command,
        'args': list(args)
        })
        
def get_orien():
    appiumlib = BuiltIn().get_library_instance('appiumlibrary')
    currdriver = appiumlib._current_application()
    return currdriver.orientation

def execute_adb_CMD(command):
       os.system(command)
    
def swipe_hubfeeds(locator):
    appiumlib = BuiltIn().get_library_instance('appiumlibrary')
    currdriver = appiumlib._current_application()
    #currdriver.swipe(locator)
    #element = appiumlib._element_find(locator, True, True)
    #driver.execute_script("mobile: scroll", {"direction": 'down', 'element': element.id})
    currdriver.execute_script('mobile: scrollBackTo', {'direction': 'left', 'xpath':locator})

def OTT_search_asset1(name,env):
    with open("Variables\\OTT\\"+env+"\\Config.yaml", 'r') as stream:
        try:
            yaml_data=(yaml.safe_load(stream))
            #print (yaml_data)
        except yaml.YAMLError as exc:
            print(exc)
    for i in name.upper():
        j = yaml_data.get(i)
        print(j)
        if j is None:
            continue
        i1 = int(j[0])
        i2 = int(j[1])
        execute_adb_shell('input tap', str(i1) + ' ' + str(i2))
        # os.system("adb shell input tap " + str(i1) + " " + str(i2))
    return True

def  tune_channelott1(channel_num):
    try:
        num=str(channel_num)
        print (num)
    except:
        print ("Please valid channel_num only!!!")
        return False
    key = ''
    for n, ch in enumerate(num):
        if n == 0:
            key1 = ' input keyevent KEYCODE_' + ch
        else:
            key1 = ' -a input keyevent KEYCODE_' + ch
        key = key + key1
    execute_adb_shell(key)

def ios_applaunch(url):
    print (url)
    appiumlib = BuiltIn().get_library_instance('appiumlibrary')
    currdriver = appiumlib._current_application()
    currdriver.get(url)

def set_orientation(mode):
    appiumlib = BuiltIn().get_library_instance('appiumlibrary')
    currdriver = appiumlib._current_application()
    print (mode)
    if mode == "Portrait":
        currdriver.orientation = "PORTRAIT"
    else:
        currdriver.orientation = "LANDSCAPE"        