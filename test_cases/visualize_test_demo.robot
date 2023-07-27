*** Settings ***
Documentation    Visual Testing With Robot Framework

Library    Browser    timeout=20s
Library    OperatingSystem
Library    String
Library    SeleniumLibrary
Library    WatchUI    tesseract_path=C:\\Program Files\\Tesseract-OCR\\tesseract.exe    

Suite Setup        Setup
# Suite Teardown    Teardown

*** Variables ***

${counter}      0

*** Test Cases ***
Scenario 1 - Verify Fullpage UI Of The Web App Display Acutually
    [Documentation]    compare the actual UI display to the BASE image, both of images should have the same dimension.
    [Tags]    regression
    New Page    https://www.epochconverter.com
    ${pageTitle}      Browser.Get Title
    ${actualImage}    Set Variable    actualDisplay_${counter}.png
    Take Screenshot   ${EXECDIR}/actual_images/${actualImage}   fullPage=${True}
    Compare Images    ${EXECDIR}/expect_images/base.png    ${EXECDIR}/actual_images/${actualImage}
    # Should Be Equal As Strings    ${pageTitle}    Epoch Converter - Unix Timestamp Converter
    [Teardown]    Clear Images After Running     ${EXECDIR}/actual_images

Scenario 2 - Verify Only The Crop UI Of The Web App Display Acutually
    [Documentation]    compare the actual UI display which is cropped to the BASE image, 
    ...    both of images should have been the same cropped dimension.
    [Tags]    regression
    New Page    https://www.epochconverter.com
    ${pageTitle}      Browser.Get Title
    ${actualImage}    Set Variable    droppedImage_${counter}.png
    Take Screenshot   ${EXECDIR}/actual_images/${actualImage}   crop={'x': 1, 'y': 1, 'width': 300, 'height': 350}
    # Crop Image        ${EXECDIR}/expect_images/base.png    1    350    300    350

    [Teardown]    Clear Images After Running     ${EXECDIR}/actual_images


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
