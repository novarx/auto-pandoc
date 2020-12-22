# Second paragraph 
## fancy plantuml
> by https://github.com/timofurrer/pandoc-plantuml-filter

Tail landjaeger ham, sausage sirloin rump pork boudin buffalo corned beef short ribs leberkas kielbasa pork chop.

```{.plantuml width=50%}
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response

Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
```

```plantuml
package "Anwendungsfälle" {
  left to right direction
  :User: --> (Anwendungsfall 1) : Send utf-8 chars, äöü
  :User: --> (Anwendungsfall 2)
  :User: --> (Anwendungsfall 3)
}
```

```plantuml
@startmindmap

* real meat
** pork
*** ham
**** cured ham
**** cooked ham
*** spare-ribs
*** short loin
** beef
*** entrecote
*** t-bone
*** stroganoff

@endmindmap
```

## Yet another usles paragraph but with SVG
Ham hock tongue bresaola bacon. Kevin turkey landjaeger sausage corned beef tail short ribs alcatra doner meatloaf pork loin. Pork loin porchetta alcatra, turducken leberkas beef kielbasa chicken strip steak biltong picanha pancetta sirloin pork belly pastrami.

![an svg](img-svg.svg)
