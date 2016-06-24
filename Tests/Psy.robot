*** Settings ***
Suite Teardown    Close Test Browser
Library           Selenium2Library
Library           Framework/SauceLabs.py
Library           String
Library           Framework/Testing.py

*** Variables ***
@{_tmpFire}       name:Testing RobotFramework Selenium2Library,browserName:firefox, platform:Windows 8,version:14
@{_tmpIE}         name:Testing RobotFramework Selenium2Library,browserName:Internet explorer, platform:Windows 8,version:10
${CAPABILITIES}    ${EMPTY.join(${_tmpIE})}
${KEY}            Barnebre:216526d7-706f-4eff-bf40-9d774203e268
${REMOTE_URL}     http://${KEY}@ondemand.saucelabs.com:80/wd/hub
${LOGIN_FAIL_MSG}    Incorrect username or password.
${Browser}        firefox
${MobileApps}     http://testlpks.landpotential.org:8105/
${XpathLandHome}    //html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/div[1]/div/img
${GoogleLoginBut}    loginGoogleWebBrowser
${GoogleSignIN}    Sign in - Google Accounts
${LandPKSSignIn}    LandPKS Sign-In
${GoogleEmail}    lpks.test@gmail.com
${GoogleEmaiPass}    landpotentialtest
${GoogleEmail1}    barnebre@gmail.com
${GoogleEmaiPass1}    _PL)OK(IJ
${GoogleEmailField}    Email
${GooglePassField}    Passwd
${GooglePassXpath}    //html/body/div/div[2]/div[2]/div[1]/form/div[2]/div/div[2]/div/div/input[2]
${GoogleSignINBut}    //html/body/div/div[2]/div[2]/div[1]/form/div[2]/div/input[1]
${GoogleApproveAccess}    submit_approve_access
${LandInfoIcon}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/div/div[1]/div[2]/img
${AddNewLandInfo}    //span[@class='right-buttons']/a[@class='button button-icon ion-plus-round']
${AddLandInfoPlotButton}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a
${PlotNameIdLI}    name
${TestPlotYesRadioIdLI}    chkTestPlotYes
${OrgFieldIdLI}    organization
${LatFieldIdLI}    latitude
${LonFieldIdLI}    longitude
${BackButPlotCssLi}    body.grade-a.platform-browser.platform-win32.platform-ready ion-nav-bar.bar-stable.bar.bar-header.bar-balanced.nav-bar-container div.nav-bar-block ion-header-bar.bar-stable.bar.bar-header.bar-balanced.disable-user-behavior div.title.title-left.header-item span.nav-bar-title a.button.button-icon
${LandInfoErrorMessage}    Answer to test plot is required.
${AlertPopUpCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-buttons button.button.ng-binding.button-positive
${ErrorMessageCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-body span
${AddPlotMenuPlotXpLI}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a
${SubmitPlotButIdLI}    btnSubmitPlot_1
${SubmitPlotErrorButCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-buttons button.button.ng-binding.button-positive
${ReviewPlotXpLi}    //div[@class='scroll']/a[9]
${LandCoverXpLi}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a[2]
${LinksAddPlot}    //div[@class='scroll']/a[@class='item item-icon-right othercomponent']
${FloodTypesXpsLI}    //div[@class='scroll']/div/div[contains(@class,'col col-5')]/img
${FloodTypesXpsLI1}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/div/div[contains(@class,'col col-5')]/img
${SoilLayersXpsLI}    //div[@class='scroll']/a

*** Test Cases ***
Get Jenkins Driver
    [Tags]    Jenkins
    Get Jenkins Platform
    Mobile Setup Jenks

Check Mobile web
    [Tags]    Mobile
    Set Selenium Timeout    15 seconds
    Set Selenium Speed    .75 seconds
    Mobile Setup

Google Login
    ${ele}=    Run Keyword And Return Status    Element Should Not Be Visible    id=account-chooser-add-account
    Run keyword if    ${ele}    Handle New Google Login
    ...    ELSE    Handle Exisiting Account
    Select Window    ${LandPKSSignIn}

Add Plot
    Add New Land Info Plot
    ${Sucess}=    Check for land info sucess
    run keyword if    ${Sucess}    Try to submit Land Info
    Check for land info sucess

Use main page to finish plot
    mobile land info using main page
    Set Selenium Timeout    5 seconds

*** Keywords ***
Open test browser
    Open browser    http://www.google.com    ${Browser}    \    remote_url=${REMOTE_URL}    desired_capabilities=${CAPABILITIES}

Open test browser2
    [Arguments]    ${Capa}
    Open browser    http://www.google.com    ${Browser}    \    remote_url=${REMOTE_URL}    desired_capabilities=${Capa}

Close test browser
    Run keyword if    '${REMOTE_URL}' != ''    Report Sauce status    ${SUITE_NAME} | ${TEST_NAME}    ${TEST_STATUS}    ${TEST_TAGS}    ${REMOTE_URL}
    Close all browsers

Mobile Setup
    Open test browser
    go to    ${MobileApps}
    Click element    xpath=${XpathLandHome}
    Click element    id=${GoogleLoginBut}

Mobile Setup Jenks
    go to    ${MobileApps}
    Click element    xpath=${XpathLandHome}
    Click element    id=${GoogleLoginBut}

Handle New Google Login
    ${window}=    Run keyword and return status    Select window    Title=${GoogleSignIN}
    wait until page contains element    id=${GoogleEmailField}
    input text    id=${GoogleEmailField}    ${GoogleEmail}
    Click Element    id=next
    wait until page contains element    id=${GooglePassField}
    focus    id=${GooglePassField}
    input text    id=${GooglePassField}    ${GoogleEmaiPass}
    Page should contain element    xpath=${GoogleSignINBut}
    Wait Until Element Is Enabled    xpath=${GoogleSignINBut}
    Wait Until Element Is visible    xpath=${GoogleSignINBut}
    Click element    ${GoogleSignINBut}
    Page should contain element    id=${GoogleApproveAccess}
    click element    id=${GoogleApproveAccess}

mobile manipulation
    go to    ${MobileApps}
    Click element    xpath=${XpathLandHome}
    Click element    id=${GoogleLoginBut}
    ${ele}=    Run Keyword And Return Status    Element Should Not Be Visible    id=account-chooser-add-account
    Run keyword if    ${ele}    Handle New Google Login
    ...    ELSE    Handle Exisiting Account
    Select Window    ${LandPKSSignIn}
    Add New Land Info Plot
    ${Sucess}=    Check for land info sucess
    run keyword if    ${Sucess}    Try to submit Land Info
    Check for land info sucess
    mobile land info using main page

mobile land info using main page
    ${count}=    Get Matching Xpath Count    ${LinksAddPlot}
    @{Links}=    Get WebElements    xpath=${LinksAddPlot}
    : FOR    ${i}    IN RANGE    1    ${count} + 1
    \    ${link}=    Get WebElement    xpath=(${LinksAddPlot})[${i}]
    \    ${Atrib}=    get element atrrib    ${link}    href
    \    click element if visable    ${link}
    \    run keyword if    '${Atrib}' == 'http://testlpks.landpotential.org:8105/#/landpks/landinfo_soillayers'    Exit for loop
    \    proc current module
    \    Try to submit Land Info
    \    Check for land info sucess
    proc soil layers

proc soil layers
    ${count}=    Get Matching Xpath Count    ${SoilLayersXpsLI}
    : FOR    ${i}    IN RANGE    1    ${count} + 1
    \    ${link}=    Get WebElement    xpath=(${SoilLayersXpsLI})[${i}]
    \    ${Vis}=    click element if visable    ${link}
    \    run keyword if    ${Vis}    proc soil layer

proc soil layer
    log    soil layer
    click element    css=html body.grade-a.platform-browser.platform-win32.platform-ready ion-nav-view.view-container ion-tabs.tabs-item-hide.pane.tabs-bottom.tabs-standard ion-nav-view.view-container.tab-content div.pane ion-view.pane ion-scroll.padding.body.scroll-view.ionic-scroll.disable-user-behavior div.scroll div.othercomponent button.button.button-balanced.button-small
    click element    css=html body.grade-a.platform-browser.platform-win32.platform-ready ion-nav-view.view-container ion-tabs.tabs-item-hide.pane.tabs-bottom.tabs-standard ion-nav-view.view-container.tab-content div.pane ion-view.pane ion-content.padding.body.scroll-content.ionic-scroll.overflow-scroll.has-header.has-footer div.scroll div#soil_form_a_ball label.item input#radioBall
    @{Elements}=    Get Webelements    tag=input
    : FOR    ${element}    IN    @{Elements}
    \    ${text}=    Get Value    ${element}
    \    run keyword unless    '${text}' == 'NO'    click element if visable    ${element}
    \    Scroll To Element    ${element}
    ${Submit}=    get web element    xpath=//div[@id='btnSelect']/button
    click element if visable    ${Submit}
    ${layer}=    Get WebElement    xpath=//div[@class='lpks-select']/input
    Click element if visable    ${layer}
    click element    xpath=/html/body/div[4]/div/div[2]/div/ion-view/ion-content/div[1]/a[1]/img
    click element if visable by locator    xpath=//html/body/ion-nav-bar/div[1]/ion-header-bar/div[1]/span/a[2]

proc current module
    @{FloodTypes}=    Get WebElements    xpath=${FloodTypesXpsLI}
    : FOR    ${FloodType}    IN    @{FloodTypes}
    \    ${Atrib}=    get element atrrib    ${FloodType}    class
    \    click element if visable    ${FloodType}
    Check for land info sucess

click element if visable
    [Arguments]    ${element}
    ${Visible}    run keyword and return status    element should be visible    ${element}
    run keyword if    ${Visible}    click element    ${element}
    [Return]    ${Visible}

click element if visable by locator
    [Arguments]    ${locate}
    ${element}=    get webelement    ${locate}
    ${Visible}    run keyword and return status    element should be visible    ${element}
    run keyword if    ${Visible}    click element    ${element}
    [Return]    ${Visible}

Try to submit Land Info
    Click link    xpath=${ReviewPlotXpLi}
    Click element    id=${SubmitPlotButIdLI}
    ${result}=    Run keyword and return status    element should be visible    css=${SubmitPlotErrorButCssLI}
    run keyword if    ${result}    click element    css=${SubmitPlotErrorButCssLI}
    [Return]    ${result}

Add New Land Info Plot
    Wait Until Element Is visible    xpath=${LandInfoIcon}
    Click element    xpath=${LandInfoIcon}
    Wait Until Element Is visible    xpath=${AddNewLandInfo}
    click element    xpath=${AddNewLandInfo}
    Wait Until Element Is visible    xpath=${AddPlotMenuPlotXpLI}
    click element    xpath=${AddPlotMenuPlotXpLI}
    Set Selenium Speed    .35 seconds
    Check for land info error
    click element    id=${TestPlotYesRadioIdLI}
    ${RandomString}=    Generate Random String    8
    @{Elements}=    Get Webelements    tag=input
    : FOR    ${element}    IN    @{Elements}
    \    ${text}=    Get Value    ${element}
    \    run keyword unless    '${text}' == 'small' or '${text}' =='medium'    input text    ${element}    ${RandomString}

Check for land info sucess
    Click element    css=${BackButPlotCssLi}
    ${result}=    Run keyword and return status    page should not contain element    css=${AlertPopUpCssLI}
    [Return]    ${result}

Check for land info error
    Click element    css=${BackButPlotCssLi}
    input text    id=${OrgFieldIdLI}    4
    page should contain element    css=${AlertPopUpCssLI}
    click element    css=${AlertPopUpCssLI}

Handle Exisiting Account
    ${idForAccount}=    get correct account    GoogleEmail
    Page should contain element    id=${idForAccount}
