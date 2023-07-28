*** Settings ***
Documentation    Common Keywords For Scripting Test Cases

Library    Browser    timeout=20s
Library    OperatingSystem
Library    String
Library    WatchUI    tesseract_path=C:\\Program Files\\Tesseract-OCR\\tesseract.exe    

*** Variables ***
${counter}      0


*** Keywords ***
Compare All Elements
    [Documentation]    This keyword is used to verify all elements of the specific keywords
    ...   The input Agurment is the endpoint of the page. For exmple: Enpoint is login for the https://the-internet.herokuapp.com/login
    [Arguments]    ${pagename}
    ${elements}    Get Elements    input, button, label, div, h1, h2, h3, h4
    FOR    ${element}    IN    @{elements}
        Log    ${element}
        ${nodeType}    Evaluate JavaScript   ${element}    (elem) => elem.getAttribute("type")    
        ${nodeName}    Evaluate JavaScript   ${element}    (elem) => elem.getAttribute("name")
        ${className}   Evaluate JavaScript   ${element}    (elem) => elem.getAttribute("class")
        ${for}         Evaluate JavaScript   ${element}    (elem) => elem.getAttribute("for")
        ${id}    Get Property    ${element}    id
        ${reference_screenshot_exists}    Run Keyword And Return Status    File Should Exist
        ...    ${EXECDIR}/outputs/reference/${pagename}_${nodeType}_${nodeName}_${for}_${id}_${className}.png
        IF    ${reference_screenshot_exists}
            Take Screenshot    filename=${EXECDIR}/outputs/actual/${pagename}_${nodeType}_${nodeName}_${for}_${id}_${className}
            ...    selector=${element}
            Run Keyword And Ignore Error    Compare Images
            ...    ${EXECDIR}/outputs/reference/${pagename}_${nodeType}_${nodeName}_${for}_${id}_${className}.png
            ...    ${EXECDIR}/outputs/actual/${pagename}_${nodeType}_${nodeName}_${for}_${id}_${className}.png    move_tolerance=10
        ELSE
            Take Screenshot    filename=${EXECDIR}/outputs/reference/${pagename}_${nodeType}_${nodeName}_${for}_${id}_${className}
            ...    selector=${element}
        END
    END


Setup
    [Documentation]  Open Chromium browser window
    New Browser    browser=chromium    headless=false
    New Context    viewport={'width': 1024, 'height': 768}


Teardown
    [Documentation]  Close the browser after execution
    Close Browser    


Clear Images After Running
    [Documentation]    Clean the actual images after running test
    [Arguments]     ${folderActualImage}
    Remove Directory    ${folderActualImage}      recursive=${True}
    Directory Should Not Exist    ${folderActualImage}/*.png

