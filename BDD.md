

## 1. Introduction:

![Build Status](https://github.com/marouaneaba/BDD_Gherkin/blob/master/BDD_AND-TDD.png)
![Build Status](https://github.com/marouaneaba/BDD_Gherkin/blob/master/1.png)

Le behavior driven developpement est une méthode créer en 2003 par Dan North. Gherkin est un langage qui permet de décrire le comportement attendu par un module, qui se base sur un formalisme : Given - When - Then Gherkin a pour objectif de promouvoir les pratiques de développement axées sur le comportement.

Les tests écris en TDD sont moins compréhensible, sont loin du langage naturel, est difficile d'étre le document sur lequel des acteurs développeur ( technique ) et PO ( métier ) peuvent echanger.

Le principe de cette méthodelogie c'est de changer le mot 'TEST' par 'Comportement'.

Gherkin un des apports majeurs du BDD, Le BDD est une méthodologie qui permet aux équipes de développement et métier de discuter avec un langage commun, qui est compréhensible par les trois acteurs de 3 amigos ( lisible par un humain ), qui peut étre aussi interprété par une machine.

The Three Amigos C'est un point (format de réunions) entre le réprésenteur du besoin (PO), un développeur, et un testeur. L'objectif de cette réunion est :

pour le PO : définir le problème que l'on cherche à adresser. 
pour le développeur : une solution pour régler ce problème, collecter des connaissance où vocabulaire métier ( nommage du code et compréhensible du besoin ). 
pour le testeur : définir les différents cas/scénarios.

au final pour le développement d'une fonctionnalité faut produire un sujet avec l’acronyme 'INVEST'.




## 2. Définir les sénarios ( Régle métier ):
![Build Status](https://github.com/marouaneaba/BDD_Gherkin/blob/master/2.png)

dans notre projet, faut créez un nouveau Source Folder que vous appellerez src/test/resources. et de créez un fichier wiki.feature dans un package dojo de src/test/resources.
Le Inttelij detecte l'extension .feature, et il faut remplir ce fichier par des scénarios.



Dans Cucumber, une story est composée des scénarios et chaque scénario est composé d'étapes. La story est d'écrite en Gherkin dans un fichier .feature dans lequel on trouve :
le titre de la story introduit par le mot clé Feature ; Feature: <Titre de la fonctionnalité>


```
*Feature : Fonctionnalité le quel on souhaite définir le comportement attendu, le méme que celui utilisé pour décrire le sénario.
```

Un descriptif (optionnel) (qui ne sera pas interprété par Cucumber) permettant par exemple, de résumer la story à l'aide du template As..., I want to..., so that... et/ou de noter toute
autre information utile à connaître ;

les scénarios de la story :
Chaque scénario est introduit par le mot clé Scenario. 


```
*Scénario : Un ensemble des cas donné pour la feature, d'une format Given - When - Then.
```


Ce mot clé peut être suivi ou non d'un titre qui décrit explicitement le critère d'acceptation de la story associée à ce
scénario,
Un scénario étant un exemple concret qui illustre une règle métier, il est composé de plusieurs étapes. Les différentes étapes d'un scénario sont décrites à partir des trois
principaux mots clés : Given, When et Then suivant la place et le rôle qu'elles occupent dans le scénario : 

```
*Given décrit les conditions initiales du scénario, c.-à-d. le contexte dans lequel va se dérouler le scénario.
*When décrit une action effectuée par un utilisateur, c.-à-d. un événement qui va réellement déclencher le scénario.
*Then décrit le comportement attendu, ce qui devrait se produire lorsque les conditions initiales sont remplies et l'action est effectuée.
```





## 3. Lanceur de test:

L'annotation @RunWith(Cucumber.class) permet d'exécuter les scénarios Cucumber dans JUnit à l'aide du JUnit Runner.
Le lanceur de test fait le mapping entre les étapes des scénarios écrites de manière naturelle (fichier .feature) et les méthodes Java implémentant ces étapes. Les étapes Java
sont appelées des steps et sont définies grâce à des annotations spécifiques : @Given, @When, @Then.

```java
package dojo;

import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
public class RunCucumberTest { }
```

## 4. Conclure:

- Ca ne veut pas dire qu’on écrit plus de tests unitaires ni de tests d’intégration.

- L’avantage du BDD est de travailler avec des scénarios de spécifications exprimés dans les termes du métiers, qui rendent les choses compréhensible pour un client.

- D’un point de vue agile, c’est une manière d’exposer les tests d’acceptations des stories. Il y a certes un effort pour écrire ces scénarios, mais au final tout le monde y gagne (lisibilité, maintenance).

- Diriger le développeur sur le développement.

- L’acronyme 'INVEST' Story.


## 5. pratique:
