*** Settings ***
Documentation    Page Object representing the TodoMVC application interface.
Library          Browser
Library          ../../libraries/custom_actions.py

*** Variables ***
${NEW_TODO_INPUT}       css=.new-todo
${TODO_LIST_ITEMS}      css=.todo-list li
${TODO_COUNT_LABEL}     css=.todo-count
${CLEAR_COMPLETED_BTN}  css=.clear-completed
${FILTER_ALL_LINK}        xpath=//a[text()='All']
${FILTER_ACTIVE_LINK}     xpath=//a[text()='Active']
${FILTER_COMPLETED_LINK}  xpath=//a[text()='Completed']

*** Keywords ***
Add New Todo Item
    [Documentation]    Types a new todo title into the input field and presses Enter.
    [Arguments]        ${title}
    Fill Text          ${NEW_TODO_INPUT}    ${title}
    Press Keys         ${NEW_TODO_INPUT}    Enter

Mark Todo Item As Completed
    [Documentation]    Toggles completion checkbox for a given todo title.
    [Arguments]        ${title}
    Click              xpath=//label[text()='${title}']/preceding-sibling::input[@class='toggle']

Delete Todo Item
    [Documentation]    Hovers over the item and clicks the destroy button.
    [Arguments]        ${title}
    Hover              xpath=//label[text()='${title}']
    Click              xpath=//label[text()='${title}']/following-sibling::button[@class='destroy']

Verify Todo Item Is Visible
    [Documentation]    Asserts that a todo item with the given text is visible in the list.
    [Arguments]        ${title}
    Get Element States    xpath=//label[text()='${title}']    contains    visible

Verify Todo Item Is Completed
    [Documentation]    Asserts that the list item containing the title has the 'completed' class.
    [Arguments]        ${title}
    Get Element States    xpath=//li[contains(@class, 'completed')]//label[text()='${title}']    contains    visible

Verify Remaining Count Equals
    [Documentation]    Uses Custom Python Keyword to verify remaining items count text.
    [Arguments]        ${expected_count}
    ${text}=           Get Text    ${TODO_COUNT_LABEL}
    Verify Items Count Text Matches    ${text}    ${expected_count}

Filter By Completed
    [Documentation]    Clicks on Completed filter tab.
    Click              ${FILTER_COMPLETED_LINK}

Filter By Active
    [Documentation]    Clicks on Active filter tab.
    Click              ${FILTER_ACTIVE_LINK}

Filter By All
    [Documentation]    Clicks on All filter tab.
    Click              ${FILTER_ALL_LINK}
