# BI-IOS 2022

| Přednáška | Přednášející | Stanford |
| --------- | -------- | -------- |
| 01 Xcode, Swift Basics | LH | [Swift](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/reading_1.pdf) |
| 02 SwiftUI Basics | LH | [Getting Started with SwiftUI](https://www.youtube.com/watch?v=bqu6BquVi2M) |
| 03 More SwiftUI | IR | [Getting Started with SwiftUI](https://www.youtube.com/watch?v=bqu6BquVi2M) |
| 04 Navigace | IR | [Learning More about SwiftUI](https://youtu.be/3lahkdHEhW8) |
| 05 Networking, multithreading | LH | Není |
| 06 Async/await | LH | Není |
| 07 MVVM | IR | [MVVM](https://youtu.be/--qKOhdgJAs)<br>[More MVVM enum Optionals](https://youtu.be/oWZOFSYS5GE) |

V průběhu kurzu doporučujeme shlédnout online přednášky ze Stanfordu, které slouží jako hlavní zdroj informací pro tento kurz [https://cs193p.sites.stanford.edu](https://cs193p.sites.stanford.edu).

## 1. domácí úkol

> :exclamation: Deadline: **15. 11. 2021 23:59:59**

> Dokumentace ke kompletnímu API je [zde](https://fitstagram.ackee.cz/docs/)

Vaším úkolem je vytvořit detailu příspěvku.

Detail bude obsahovat všechny fotografie, které jsou u příspěvku nahrány = může jich být více než jenom jedna. Zobrazení je na vás, ale může se hodit pogooglit, jak se dělá `pageView` ve SwiftUI. :bulb: :smirk:

Na detailu budé také vidět autorovo uživatelské jméno a nějak hezky do toho zakomponujte komentáře u daného příspěvku – všechno bude zobrazeno na jedné obrazovce.

Pro načtení komentářů použijte následující url:
```
https://fitstagram.ackee.cz/api/feed/{postID}/comments
```
kde místo `{postID}` dáte ID postu, které přijde z Feedu. Na cviku jsme si říkali něco o tom, jak neblokovat hlavní vlákno, zkuste to dodržet. :pray:

Všechny tyto věci zkuste hezky spojit na jedné obrazovce.

Odevzdávání můžete udělat přes mail `lukas.hromadnik@ackee.cz` nebo mě pozvěte do svého repa, kde budete mít řešení, a na mail mi pošlete větev / commit, kde řešení najdu.

**Bonus** (max 2 body): Přijde na obrazovku tlačítko nebo nějakou jinou akci, pomocí které se skryjí / zobrazí ostatní informace až na fotky. Tedy provedu akci, všechno až na fotky zmizí, udělám znova akci a informace se zobrazí zpět. Nechceme zobrazit novou obrazovku, kde budou pouze fotky, ale upravit tu stávající.

## Semestrální práce

V rámci semestrální práce je vaším úkolem ukázat, co jste se naučili. Téma je na vás, ale je potřeba si ho nechat mnou schválit. Schválení musí proběhnout do konce výuky, tedy do posledního cvika.

Na vypracování pak máte celý semestr – až do konce zkouškového.

Odevzdávání, pokud nám to situace dovolí, bude probíhat osobně [u nás v kancelářích](https://mapy.cz/zakladni?source=firm&id=12749992&ds=1&x=14.3907423&y=50.0997880&z=17). Nenechávejte odevzdání na poslední chvíli, aby na vás vystačil nějaký termín. Může se stát, že pokud necháte odevzdání do posledního dne, nebude možné pro vás najít termín na odevzdání a tedy i dokončit předmět.

Pokud to situace nedovolí, bude odevzdávání online.

Rozsah práce by mělo být 3 - 5 obrazovek (může být míň, pokud to dává smysl v rámci zadání) s použitím architektury MVVM. Ideálně ukázat nějaké zajímavější věci než jenom statické obrazovky – networking, multithreading, gesta, mapa, výběr obrázků, malování, atd.

## Přednášky

### 01 Xcode, Swift Basics
* Xcode
* Swift
  * `String`, `Int`, `Bool`, `Double`
  * podmínky, cykly
  * `Optional`
  * Pole, dictionaries, tuples
  * `struct`, `enum`, `class`
  * Protokoly, extensions 

### 02 SwiftUI Basics
* Swift
  * Access control
  * Trailing closure syntax
* SwiftUI
  * `View`, `some`, `@ViewBuilder`
  * `VStack`, `HStack`, `Text`, `Button`, `Image`
  * SFSymbols

### 03 More SwiftUI
* Sizing (top-down, bottom-up)
* View modifiers
* `LazyVGrid`/`LazyHGrid`
* `ForEach`
* `ScrollView`
* Protocols
  * `Equatable`
  * `Hashable`
  * `Identifiable`
  * `Comparable`

### 04 Navigation
* Human Interface Guidelines
* Xcode shortcuts
* `List`
* Property wrappers
* `@State`, `@Binding`, `@Environment`
* View presentation
  * Alert
  * Sheet
  * `fullScreenCover`
* `NavigationStack`, `NavigationLink`, `NavigationPath`
* `TabView`

### 05 Networking
* Closures
* REST, API
* Request
* `URLSession.shared.dataTask`

### 06 Async/Await
* `Codable`
  * `CodingKeys`
  * `init(from decoder: Dedocer)`
  * `encode(to encoder: Encoder)`
  * zanořené objekty
* Async/await
  * `Task`
  * `@MainActor`
  * func async

### 07 MVVM
* MVVM architecture
* `ObservableObject`, `ObservedObject`/`StateObject`, `@Published`
* Value types vs. reference types
* `enum` associated values
* Error handling and debugging basics