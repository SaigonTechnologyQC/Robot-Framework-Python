*** Settings ***
Documentation    Visual Testing With Robot Framework

Library    Browser    timeout=20s
Library    OperatingSystem
Library    String
Library    WatchUI    tesseract_path=C:\\Program Files\\Tesseract-OCR\\tesseract.exe    

Suite Setup        Setup
Suite Teardown    Teardown

*** Variables ***

${counter}      0

*** Test Cases ***
Scenario 3 - Mobile Web Test
    ${device}=  Get Device  iPhone X
    New Context  &{device}
    New Page    https://www.epochconverter.com
    ${pageTitle}      Browser.Get Title
    Should Be Equal As Strings    ${pageTitle}    Epoch Converter - Unix Timestamp Converter
    ${screenSize}     Get Viewport Size  # returns { "width": 375, "height": 812 }


*** Keywords ***
Setup
    New Browser    browser=chromium    headless=false
    New Context    viewport={'width': 1024, 'height': 768}

Teardown
    Browser.Close Browser    

Clear Images After Running
    [Documentation]    Clean the actual images after running test
    [Arguments]     ${folderActualImage}
    Remove Directory    ${folderActualImage}      recursive=${True}
    Directory Should Not Exist    ${folderActualImage}/*.png
