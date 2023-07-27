from hashlib import new
from inspect import Attribute
from os import access
from unittest import TestResult
from robot.libraries.BuiltIn import BuiltIn
import requests
import json

class ZephyrListener:
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, projectKey, testCycleKey):
        self.projectKey = projectKey
        self.testCycleKey = testCycleKey

    def start_suite(self, name, attributes):
        attributes['doc'] = 'Documentation set by listener'

    # def start_test(self, name, attributes):
    #     print(f'===== START TEST EXECUTION =====')
        
    def end_test(self, name, attributes):
        testCaseKey = name.split()[0].replace('[','').replace(']','')
        testResult = attributes['status']
        testComment = attributes['message']
        if attributes['status'] == 'SKIP':
            testResult = 'Not Applicable'
        create_test_execution(self.projectKey, self.testCycleKey, testCaseKey, testResult, testComment)
        # if attributes['status'] == 'FAIL':
        #     print('Test case "%s" is FAILED \n: %s' % (testCaseKey, attributes['message']))
        # elif attributes['status'] == 'SKIP':
        #     print('Test case "%s" is SKIPPED \n: %s' % (testCaseKey, attributes['message']))
        # else:
        #     print('Test case "%s" is PASSED \n' % (testCaseKey))       

    def end_suite(self, name, attributes):
        print('=== ALREADY UPDATE TEST RESULT INTO THE ZEPHYR SCALE ===')


def create_test_execution(projectKey, testCycleKey, testCaseKey, testResult, testComment) -> None:
    url = "https://api.zephyrscale.smartbear.com/v2/testexecutions"
    accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjb250ZXh0Ijp7ImJhc2VVcmwiOiJodHRwczovL3NhaWdvbnRlY2hub2xvZ3ktaG9uZ2xlLmF0bGFzc2lhbi5uZXQiLCJ1c2VyIjp7ImFjY291bnRJZCI6IjYyZGIwNzc1OTZmMjM5Y2E2YWU4YWJiYyJ9fSwiaXNzIjoiY29tLmthbm9haC50ZXN0LW1hbmFnZXIiLCJzdWIiOiJjNThkNTI4MS03MGViLTNjNWMtYTY1MS00ZjRiN2QyODEzOWIiLCJleHAiOjE3MjE5ODU2OTgsImlhdCI6MTY5MDQ0OTY5OH0.goi-Alin-MGQLrRFQuuKSHibfavCpPvMM-EZGbhGuh4"
    payload = json.dumps({
        "projectKey": projectKey,
        "testCaseKey": testCaseKey,
        "testCycleKey": testCycleKey,
        "statusName": testResult,
        "testScriptResults": None,
        "environmentName": None,
        "actualEndDate": "",
        "executionTime": "",
        "executedById": "",
        "assignedToId": "",
        "comment": testComment,
        "Tester": "QA.Robot"
    })
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {accessToken}'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
