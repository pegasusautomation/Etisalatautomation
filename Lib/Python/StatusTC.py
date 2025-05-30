import json
import requests

def status(execution_id,status):

    statusres = {"execution_id" : execution_id, "status" : status}
    Post_Result(statusres)
    return status

def Post_Result(dict_data):
    print("JS,", dict_data)
    url = "http://13.126.15.83:5000/update_build_status?build_details="
    data = json.dumps(dict_data)
    print(type(data), "jsondata")
    x = requests.post(url + data)
    return x