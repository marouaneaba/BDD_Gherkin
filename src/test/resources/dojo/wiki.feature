Feature: Wiki search

  As Romeo, I want to offer a drink to Juliette so that we can discuss together (and maybe more).

  Background:
    Given Romeo who wants to search a term
    When  send request an the API


  Scenario: Creating an empty request
    Then  there is 0 cocktails in the order

  Scenario Outline: Sending a request to consume the API
    When  an order is declared for <to>
    And  a message saying "<message>" is added
    Then the ticket must say "<expected>"

    Examples:
      | to       | message     | expected                            |
      | Juliette | Wanna chat? | From Romeo to Juliette: Wanna chat? |
      | Jerry    | Hei!        | From Romeo to Jerry: Hei!           |
        # ...

  Scenario : Search article in Wikipedia

    Given Enter search term 'Cucumber'
    And is a valid term
    And an ATM with money in it
    When Do search
    Then we check is valid word
    And Single result is shown for 'Cucumber'

  Scenario : Parse one article of list fetching in Wikipedia

    Given Enter search term 'Cucumber'
    And is a valid term
    And an ATM with money in it
    When Do search
    Then we check is valid word
    And Single result is shown for 'Cucumber'

  Scenario : Fetch empty result in wiki

    Given Enter search term 'Cucumber'
    And is a valid term
    And an ATM with money in it
    When Do search
    Then we check is valid word
    And Single result is shown for 'Cucumber'

