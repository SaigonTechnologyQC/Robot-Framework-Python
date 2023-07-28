*** Settings ***
Documentation    Visualize Test For All The Specific Pages

Resource    ${EXECDIR}/resources/keywords/commons.robot

Suite Setup       Setup
Suite Teardown    Teardown

*** Variables ***

${counter}      0
*** Test Cases ***
[WD-1] - Verify Fullpage UI Of The Web App Display Acutually
    [Documentation]    compare the actual UI display to the BASE image, both of images should have the same dimension.
    [Tags]    regression
    New Page    https://www.epochconverter.com
    ${pageTitle}      Get Title
    ${actualImage}    Set Variable    actualDisplay_${counter}.png
    Take Screenshot   ${EXECDIR}/outputs/actual_images/${actualImage}   fullPage=${True}
    Compare Images    ${EXECDIR}/resources/data/reference/base.png    ${EXECDIR}/outputs/actual_images/${actualImage}
    # Should Be Equal As Strings    ${pageTitle}    Epoch Converter - Unix Timestamp Converter
    [Teardown]    Clear Images After Running     ${EXECDIR}/actual_images

[WD-2] - Verify Only The Crop UI Of The Web App Display Acutually
    [Documentation]    compare the actual UI display which is cropped to the BASE image, 
    ...    both of images should have been the same cropped dimension.
    [Tags]    regression
    New Page    https://www.epochconverter.com
    ${pageTitle}      Get Title
    ${actualImage}    Set Variable    droppedImage_${counter}.png
    Take Screenshot   ${EXECDIR}/outputs/actual_images/${actualImage}   crop={'x': 1, 'y': 1, 'width': 300, 'height': 350}
    # Crop Image        ${EXECDIR}/resources/data/reference/base.png    1    350    300    350

    [Teardown]    Clear Images After Running     ${EXECDIR}/actual_images
