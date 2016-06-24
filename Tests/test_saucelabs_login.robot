*** Settings ***
Test Setup        Open test browser
Test Teardown     Close test browser
Library           Selenium2Library

*** Variables ***
${BROWSER}        firefox
${REMOTE_URL}     ${EMPTY}
${DESIRED_CAPABILITIES}    ${EMPTY}
${LOGIN_FAIL_MSG}    Incorrect username or password.

*** Test Cases ***
Incorrect username or password
    [Tags]    Login
    Go to    https://saucelabs.com/login
    Page should contain element    id=username
    Page should contain element    id=password
    Input text    id=username    anonymous
    Input text    id=password    secret
    Click button    id=submit
    Page should contain    ${LOGIN_FAIL_MSG}

*** Keywords ***
Open test browser
    Open browser    about:    ${BROWSER}    remote_url=${REMOTE_URL}    desired_capabilities=${DESIRED_CAPABILITIES}

Close test browser
    Run keyword if    '${REMOTE_URL}' != ''    Report Sauce status    ${SUITE_NAME} | ${TEST_NAME}    ${TEST_STATUS}    ${TEST_TAGS}    ${REMOTE_URL}
    Close all browsers
