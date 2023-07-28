*** Settings ***
Library     Browser    timeout=20s
Library     DocTest.VisualTest
Library     OperatingSystem

*** Test Cases ***
[WD-T5] - Compare Elements Of The Login Page And Homepage
    [Documentation]     This test case check the visualize of all elements of the Login and Homepage
    [Tags]    regression    smoke    sensitive
    New Browser    browser=chromium    headless=True
    New Page    url=https://the-internet.herokuapp.com/login
    Compare All Elements    Login
    Fill Text    //input[@name='username']    tomsmith
    Fill Text    //input[@name='password']    SuperSecretPassword!
    Click    button >> text=Login
    Get Text    .flash    *=    You logged into a secure area!
    ${pagename}    Set Variable    Login_Successful
    Compare All Elements    LoginSuccessful


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
