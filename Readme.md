# BDD - Behavior Driven Development

Dojo use Behavior Driven development, November 2019, animated by marouane abakarim AXA France.<br/>

### Introduction :
Le behavior driven developpement est une méthode créer en 2003 par Dan North.
Les tests écris en TDD sont moins compréhensible, sont loin du langage naturel, est difficile d'étre le document sur lequel des acteurs développeur ( technique ) et PO ( métier ) peuvent echanger.

### L'objectif :
##### 2.1 Fonctionnelle:
Le principe de la méthodelogie c'est de changer le mot 'TEST' par 'Comportement'.


```java
public class WikipediaTest {

    testFindArticleByWord(){
        // check if Wikipedia get article by the word
    }
    
    testFaildForEmptyWord(){
        // check if fails when searsh with empty word   
    }
    
}
```

```java
public class WikipediaBehaviour {

    shouldFindArticleByWord(){
        // check if Wikipedia get article by the word
    }
    
    shouldFailedForEmptyWord(){
        // check if fails when searsh with empty word   
    }
    
}
```

Gherkin est un langage qui permet de décrire le comportement attendu par un module, qui se base sur un formalisme :
Given - When - Then
Gherkin a pour objectif de promouvoir les pratiques de développement axées sur le comportement.

##### Mots clés:
- Feature :
Fonctionnalité le quel on souhaite définir le comportement attendu, le méme que celui utilisé pour décrire le sénario.


```GHERKIN
Feature : Search article in Wikipedia

    Given Enter search term '<searchTerm>'
    When Do search '<searchTerm>'
    Then Multiple results are shown for '<result>' 
```
  

- Scénario :
Un ensemble des cas donné pour la feature, d'une format Given - When - Then.
```GHERKIN
Scenario : Search article in Wikipedia

   Given Enter search term 'Cucumber'
    And is a valid term
    And an ATM with money in it
    When Do search
    Then we check is valid word
    And Single result is shown for 'Cucumber'
```

- Steps : 
Mot-clés qui permettent d'articuler un scénario.

```GHERKIN
   Given 
    And 
    When 
    Then
    And 
```

- Outline :

On peut utiliser des templates scénario Gherkin, pour éviter de se répeter les scénario.
```GHERKIN
Scenario : Search article in Wikipedia

   Given Enter search term <word>
    And is a valid term
    And an ATM with money in it
    When Do search
    Then we check is valid <word>
    And Single result is shown for <Articles>
```



##### 2.2 Collaboration métier/technique:

Gherkin un des apports majeurs du BDD, Le BDD est une méthodologie qui permet aux équipes de développement et métier de discuter avec un langage commun, qui est compréhensible par les trois acteurs de 3 amigos ( lisible par un humain ), qui peut étre aussi interprété par une machine

The Three Amigos
C'est un point (format de réunions) entre le réprésenteur du besoin (PO), un développeur, et un testeur.
L'objectif de cette réunion est :

pour le PO : définir le problème que l'on cherche à adresser.
pour le développeur :  une solution pour régler ce problème, collecter des connaissance où vocabulaire métier ( nommage du code et compréhensible du besoin ).
pour le testeur : définir les différents cas/scénarios.


### TDD and BDD:
Cependant, Dan North répond dans un article que le BDD va plus loin. C'est une méthode qui ne se limite pas à l'implémentation technique, et qui embarque également les fonctionnels, testeurs, et futurs utilisateurs dans la rédaction des scénarios à implémenter. Il reconnait cependant que dans un contexte où il n'y a que des développeurs, BDD et TDD sont équivalents.

On peut noter que BDD et DDD (Domain Driven Design) stratégique sont très liés, car il s'agit d'une méthode qui va plus loin que la "simple" implémentation technique, et elle implique également des changements organisationnels.

Certains résument la différence entre BDD et TDD ainsi :

TDD : make the things right

BDD : make the right thing

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


----
## Qu'est ce que le BDD ?
- C'est avant tout une méthode Agile qui favorise la conversation entre les développeurs (DEV), les responsables qualités (QSI), les intervenants non-techniques (PO/BA) et les dépendances (adhérences avec d'autres équipes)<br/>

- C'est une partie de la spécification par l'exemple qui vise à spécifier ensemble via des conversations pour sortir des règles et des exemples.<br/>
- C’est également une pratique de développement (et pas une pratique de test...) qui vise à automatiser un critère d'acceptation formalisé à l'aide de la syntaxe Gherkin. <br/>

- L'atelier 3 Amigos est un pré-requis pour la mise en oeuvre de la pratique de DEV. C'est en effet durant cet atelier que les exemples qui illustrent le comportement d'une règle métier sont définis (Example Mapping).<br/>
- Les exemples automatisés par le développeur sont archivés dans GIT et exécutés via une Build. <br/>
- Idéalement les tests automatisés doivent remonter dans l'outil de suivi des tests pour apparaître dans le "cahier de recette"<br/>
- Il est possible également de mettre à disposition ces exemples sur un site Web avec l'outil PicklesDoc.   <br/>
## BDD versus TDD
- Les critères d'acceptations (Exemples issus de l'atelier 3 Amigos) sont posés avant de développer en tant que scénarios Gherkin<br/>
- Le développeur fait des cycles de TDD pour faire passer en vert les scénarios<br/>
- Les tests unitaires posés lors des cycles TDD ne doivent pas être sur le même périmètre de test, ils doivent rajouter des exigences techniques.<br/>
- D'autres tests unitaires sont ajoutés lors de la partie Refactor pour les concepts Clean Clode.<br/>
- Les Tests BDD sont donc les tests fonctionnels<br/>
- Les Tests TDD sont donc les tests techniques<br/>
## Bénéfices
### Documentation vivante
Gherkin est une syntaxe naturelle qui est comprise par tous. Ces tests sont archivés et exécutés à chaque mise à jour du code. Associé à Pickles, nous disposons alors d'une documentation HTLM à jour du projet.  <br/>
### Non régression fonctionnelle
Lorsqu'un développeur modifie une méthode existante, il relance les tests Gherkin avec les tests unitaires associés afin de s'assurer que sa modification n'a pas impacté l'existant. Cela offre un feedback immédiat sur une éventuelle régression.<br/>
### Mesure de l’avancement du projet
Si BDD est appliqué au sein du projet, nous sommes en mesure de déterminer l'avancement de l'implémentation du code grâce aux tests Gherkin.<br/><br/>
## Formalisme et exemple
Given / Etant donné que

When / Quand

Then / Alors

Exemple :

Fonctionnalité : Déstockage d’inventaire

Scénario : Déstockage lors d’une commande avec un seul type d’article
Etant donné que le stock de laptop est de 3 unités
Quand je vends 2 laptops
Alors le stock de laptops est de 1 unité

