*** Settings ***
Documentation    Visualize Test Demo For Each Elements Of The Speicific Page

Resource    ${EXECDIR}/resources/keywords/commons.robot


*** Test Cases ***
[WD-T5] - Compare Elements Of The Login Page And Homepage
    [Documentation]     This test case check the visualize of all elements of the Login and Homepage
    [Tags]    regression    smoke    sanity
    New Browser    browser=chromium    headless=True
    New Page    url=https://the-internet.herokuapp.com/login
    Compare All Elements    Login
    Fill Text    //input[@name='username']    tomsmith
    Fill Text    //input[@name='password']    SuperSecretPassword!
    Click    button >> text=Login
    Get Text    .flash    *=    You logged into a secure area!
    ${pagename}    Set Variable    Login_Successful
    Compare All Elements    LoginSuccessful
