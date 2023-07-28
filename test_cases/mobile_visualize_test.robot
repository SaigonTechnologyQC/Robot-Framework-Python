*** Settings ***
Documentation    Verify Responsive UI Of Login

Resource    ${EXECDIR}/resources/keywords/commons.robot

Suite Setup       Setup
Suite Teardown    Teardown

*** Test Cases ***
[WD-3] - Mobile Web Test
    [Tags]    smoke
    ${device}=  Get Device  iPhone X
    New Context  &{device}
    New Page    https://www.epochconverter.com
    ${pageTitle}      Get Title
    Should Be Equal As Strings    ${pageTitle}    Epoch Converter - Unix Timestamp Converter
    ${screenSize}     Get Viewport Size  # returns { "width": 375, "height": 812 }

