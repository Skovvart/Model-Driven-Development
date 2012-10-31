Model-Driven-Development
========================

_Introduction_

Communication between programmers and managers can in many ways be cumbersome and it requires insight to their respective domains. 
Behavior-Driven Development (BDD) helps this communication by specifying a way in which user specifications can be written in a structured human-readable form of English, which then can be mapped directly to software tests. 
This allows managers to ensure that the specification is written down correctly, and allows programmers to automatically run tests to assert that the software follows the specifications. 

While testing ensures that software works in most cases, sometimes most is not good enough. This might be in the case of developing a driver for a space shuttle, where an error in the driver might cause a crash and end-up costing billions of dollars. 
Programming by contract solves this problem by introducing formal methods into software development, and allows to formally specify the behaviour of loops, routines and objects. 

_Scientific Problem_

The purpose of this project is to introduce programming by contract to the concept of BDD. 
An attempt will be made to design and implement a BDD-based framework that allows specifying contracts in human readable language in addition to existing features that can be extracted to tests. 
This includes extending the already existing feature description language with new constructs, and create a new DSL which specifies the mapping between the natural language form and the formal contracts. 
In the end we will, by comparing the level of expressiveness to existing contract implementations, reflect on the feasibility of designing such a language, and examine the possibility of using these extensions in the real world. 

_State of the Art_

There exists several implementations of BDD-tools such as JBehave# for Java and Cucumber# for Ruby. However, none of the currently available BDD-tools support programming by contract and an extension of the BDD concept is required to include such feature. 

Regarding programming by contract, there exist tools like Business Object Notation# (BON) that allows describing contracts in informal english. Though BON requires some domain specific knowledge in object oriented modelling, like classes, relations and inheritance; and is therefore may not be as approachable as BDD features. 


_Method_

We will begin by specifying the structure of the human-readable contracts. 
We will then implement a prototype BDD-framework in Java using model driven engineering that supports regular BDD-features and additionally formal contracts. 
Specifically we will use model-to-model transformation or code generation for translating feature descriptions into formal contracts, and code generation to incorporate the contracts into Java/JML. 

We will then evaluate and reflect on the feasibility of doing BDD in Java, by doing a case-study analysis on an existing project, applying our extension to a fragment of it and then investigate if there is a perceivable change in robustness and if there are some additional bugs which can be uncovered.