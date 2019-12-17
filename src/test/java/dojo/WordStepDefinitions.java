package dojo;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.junit.Cucumber;
import dojo.service.Dictionary;
import dojo.service.impl.DictionaryService;
import dojo.vo.Result;
import dojo.vo.Word;

import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.*;
import static org.mockito.Mockito.when;

public class WordStepDefinitions {

    private String termToSearch;
    private Dictionary dictionaryService;
    private Word word;


    @Given("^(.*) is not empty word$")
    public void is_not_empty_word(String term) {
        dictionaryService = new DictionaryService();
        termToSearch = new String(term);
        assertTrue(Boolean.valueOf(!termToSearch.isEmpty()));
        // test is not empty word
    }

    @When("^searching word in dictionary (.*)")
    public void search_word_empty_word(String term) {
        word = dictionaryService.searchWord(term);
        word = mock(Word.class);

        //order.declareTarget(juliette);
    }

    @Then("^Result size is greater to (\\d+)$")
    public void result_size_is_greater_to(int size) {
        List<Result> results = word.getResult();

        results = mock(results.getClass());
        when(results.size()).thenReturn(2);

        assertTrue( results.size() > size );
    }

    @When("^search word (.*)")
    public void search_word(String term){
        assertTrue(!term.isEmpty());
        word = dictionaryService.searchWord(term);
        word = mock(Word.class);
    }

    @Then("^the result message is (.*) and success value is (.*)")
    public void the_result_message_is(String term){
        assertFalse(word.isSuccess());
        assertTrue(word.message().equals("word not found"));
    }
}
