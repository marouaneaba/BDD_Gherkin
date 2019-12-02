# BDD - Behavior Driven Development


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
    When Do search
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
