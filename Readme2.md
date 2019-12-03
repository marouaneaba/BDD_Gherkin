# Kata Cucumber / Mockito


Pour lancer l'exemple avec maven:

	marouaneab:cucumber-mockito-shakespeare mosser$ mvn clean package

Avertissement: Le but de ce kata est de mettre l'accent sur la notion de test d'acceptation (Cucumber) et d'utilisations de bouchons dans une arhcitecture (mockito). Java n'y est vu que comme un support.

## Contexte: User story


As a (user), I want to (action) so that (benefit).

  1. transformer la story en élément spécifiable, l’implémenter sous la forme d’un test pour la vérifier (tests unitaire / intégration)
  2. mieux: écrire la spec comme un test unitaire, avant le code. C’est du test-driven development, et c’est so 2002.
  3. mieux au carré: utiliser directement la story comme un test. 



## Thème: chercher un mot dans le wikipedia 


Epic traitée dans le kata :
 
  //As particular, I want to search à term in  wiki .//



## Objectif du kata


  - Utiliser Cucumber dans un projet Java
  - Déclarer des specs avec Cucumber
  - Rendre les étapes de scénarios paramétrables, et les scénarios aussi
  - Utiliser des mocks pour simuler aux interfaces.

## Phase 1 : Utilisation de Cucumber

### Setup du projet.


On prend maven pour se simplifier la vie. (oui, vraiment)

	$ touch pom.xml

Dans le POM, on charge Junit, cucumber4java et le lien entre les deux. That’s all folks. J’ai dit simple.

```
<?xml version="1.0" encoding="UTF-8"?>
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>codingdojo</groupId>
    <artifactId>kata-bdd</artifactId>
    <version>1.0-SNAPSHOT</version>
    <dependencies>
        <dependency>
            <groupId>info.cukes</groupId>
            <artifactId>cucumber-java</artifactId>
            <version>1.2.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>info.cukes</groupId>
            <artifactId>cucumber-junit</artifactId>
            <version>1.2.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

	$ mkdir -p src/main/java/dojo src/test/java/dojo src/test/resources/dojo
	$ mvn clean package

build success, on est bon.

import dans IntelliJ comme un projet Maven, JDK 1.8. Il y a un plugin Cucumber4Java pour IntelliJ


### Setup de Cucumber

Cucumber va faire la glue entre le code de test qu’on va écrire pour opérationaliser la spec et une description de la story. Le langage utilisé pour décrire nos stories est Gherkin, un DSL dédié à la spécifications (//teasing cours IDM-1 en 5A//).

On crée un fichier de test qui va se contenter de déclencher Cucumber. Le reste est automatique, on ne va plus écrire de test unitaire directement, mais des scénarios métiers au niveau de l’architecture fonctionnelle.

Fichier "`RunCucumberTest.java`", dans `test/java/dojo`:

```
package dojo;

import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
public class RunCucumberTest { }
```


On crée maintenant un fichier de feature qui décrit notre epic. Fichier `test/resources/dojo/wikipedia.feature`

```
Feature: Wiki search

  As particular, I want to searcho term.
```

On peut lancer le fichier RunCucumberTest, le test n’est pas lancé, normal, il est vide pour le moment.

### Premier morceau de concombre


Première story. 

Small tiny steps. 

Qu’est-ce qui est minimal dans notre epic? 

Pourvoir créer une commande vide. Gherkin utilise une syntax Given/When/Then pour créer des scénarios, mais on retrouve les basics de la story derrière : un triplet (persona, action, bénéfice).


Donc, on spécifie notre système comme suit:

    Scenario: Search term in wikipedia API
      Given Enter search term 
      When  Do search term
      Then  Multiple results are shown for result

On lance le test. Junit rale, normal, il ne sait pas quoi faire de notre spec.

On va décrire les étapes du scénario dans une classe java (`WekipediaSearchService.java`):

```
package dojo;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import static org.junit.Assert.*;

import java.util.List;

public class WekipediaSearchService extends AbstractTest{

    // wiki : WS 'bean' configurer
	private String wikiWebSerice;
	private List<Article> articles;
	private String term;

	@Given("^Enter search term$")
	public void search_for(String searchTerm) {
		term = new term("cucumber");
	}

	@When("^Do search term$")
	public void do_search_term() {
		articles = wikiWebSerice.findTerm(term);
	}

	@Then("^Single result is shown for$")
	public void single_result_returned(String searchResult) {
		assertTrue(articles.size() == 1);
		assertTrue(results.getText().startsWith(searchResult));
	}
}
```

Il faut du coup aussi créer la classe Article, et les méthodes qui vont bien (dans main cette fois, pas dans test). 
Faut créer un bean configurer pour le templateService.

IntelliJ: On utilise alt / create method dans la classe de specs pour créer les méthodes. 

On parle de Behavioral-driven, dans le sens ou le comportement fait émerger l’API public. 

On expose une api publique uniquement dirigée par le métier, et pas par la structure. C’est très loin d’être évident à faire sur de gros projets, il faut de l’expérience et une certaine "excellence technique" qui vient uniquement avec le temps.

Fichier `Article.java`

```
package dojo;

import java.util.ArrayList;
import java.util.List;

public class Order {

	private String title;
	private List<String> term = new ArrayList<>();
	private String text;

	public void setTitle(String title) {
		this.title = title ;
	}

	public void setText(String text) {
		this.text = text ;
	}

	public List<String> getTitle() {
		return this.title;
	}
	
	public List<String> getTexte() {
		return this.texte;
	}
}
```

On lance le test, il passe. **En vrai il faudrait d’abord faire échouer le test, puis implémenter ce qui le fait passer.** Mais la timebox joue contre nous => on va a l’essentiel.

Avertissement: Oui, en java, on déclare des getters et des setters, on utilise un constructeur pour créer une instance, ... soit. mais là n'est pas la question.

### Rendre les étapes de tests paramétrable

Tom et Jerry?

On va essayer de rendre les étapes de scénarios paramétrable, pour pouvoir s’en servir dans d’autres scénarios.

Qu’est-ce qui serait réutilisable dans nos étapes? Tout en fait ! On peut changer les terms !

en fait, si on regarde les annotations Java utilisée, elles reposent sur des expressions rationnelles (oui, ça sert dans autre chose que pour écrire des compilateurs ou reconnaitre abbabbab).

Donc, on va définir des expressions rationnelles dans nos annotations, et Cucumber va automatiquement les matcher et les passer en paramètre des fonctions d’étapes.

  - Matcher un prénom: (.*)
  - Matcher un entier: (\\d+)

```
	@Given("^Enter search term (.*)$")
	public void search_for(String term) {
		term = new term(term);
	}

	@When("^Do search term$")
	public void do_search_term() {
		articles = wikiWebSerice.findTerm(term);
	}

	@Then("^Single result is shown for (.*)$")
	public void single_result_returned(int n) {
		assertTrue(articles.size() == 1);
		assertTrue(results.getText().startsWith(searchResult));
	}
```
Le test passe toujours. On est iso-fonctionnel, mais les étapes sont maintenant paramétrables.

Mais comment tester ça sur plusieurs scénario? Plusieurs responce API? On va utiliser une "base d’exemples", et rendre paramétrable le scénario lui-même et plus seulement les étapes.

    Scenario Outline: Searching term in wiki API

      Given wants to search a "<term>" in wiki
      When  do search
        And  with no valid "<term>"
      Then return the "<result>"" list

      Examples:
        | Term     | expected                            |
        | empty | empty list |
        | no valid term        | error message "no found term"             |
        | valid term        | list of a size between one or more             |
        # ...

On lance, ça passe. Regarder le nombre d’étapes exécutées, bien plus que ce qu’on a écrit. 

Dérouler le résultat ses Junit dans IntelliJ. On voit toutes les instances du scénarios développé.

Minimiser son effort. Be Lazy.


### Retrospective apport BDD


On vient de voir comment Cucumber pouvait nous aider à :

  - Écrire des specs presque comme des stories
  - Mapper ces specs sur des tests U
  - Rendre le tout paramétrable a coup d’expressions rationnelles.

Software engineering rocks ^^.

Attention, ça ne veut pas dire qu’on écrit plus de tests unitaires ni de tests d’intégration. Loin de là. On va forcément avoir des tests à écrire sur des fonctionalités précises. 

L’avantage du BDD est de travailler avec des scénarios de spécifications exprimés dans les termes du métiers, qui rendent les choses compréhensible pour un client. 

D’un point de vue agile, c’est une manière d’exposer les tests d’acceptations des stories. Il y a certes un effort pour écrire ces scénarios, mais au final tout le monde y gagne (lisibilité, maintenance).


Cela revient à définir ce qu’est le métier. Et c’est pas simple.


