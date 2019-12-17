Feature: searching word in dictionary (API)

  search the definition of a word
  IHM that controls the word must not be empty

  Background:
    Given aa is not empty word
    When  searching word in dictionary aa


  Scenario: search for not empty word
    Then  Result size is greater to 1


    #search not valid world -> {"success":false,"message":"word not found"}
    #search valid world
    #search empty word*/




  Scenario Outline: Search not valid or empty word in dictionary
    When  search word "<word>"
    Then the result message is "<expected>" and success value is "<success>"

    Examples:
     | word     | expected            | success   |
     | ****     | word not found      | False     |
     | AAAAA    | word not found!     | False     |
     | Cucumber | ......              | True      |
     # ...

  #Scenario : Search valid word in dictionary

    #Given Enter search term 'Cucumber'
    #And is a valid term
    #And an ATM with money in it
    #When Do search
    #Then we check is valid word
    #And Single result is shown for 'Cucumber'

  #Scenario : Search valid word and return one or more result // Parse one article of list fetching in Wikipedia

    #Given Enter search term 'Cucumber'
    #And is a valid term
    #And an ATM with money in it
    #When Do search
    #Then we check is valid word
    #And Single result is shown for 'Cucumber'

  #Scenario : Fetch empty result in wiki

    #Given Enter search term 'Cucumber'
    #And is a valid term
    #And an ATM with money in it
    #When Do search
    #Then we check is valid word
    #And Single result is shown for 'Cucumber'
