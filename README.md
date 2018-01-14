# Zaawansowane języki programowania 17/18

# Projekt na egzamin:
# “ Gra w życie Conway’a – refaktoryzacja kodu w języku Ruby”

#### Grupa “POP”:

Piotr Lisek
Aleksandra Burkiewicz
Patrycja Cieślak




#### Wstęp – cel projektu

Projekt ma na celu wprowadzenie zmian w kodzie zapisanym w języku Ruby obrazującym algorytm na którym bazuje “Gra o życie”. Na drodze refaktoryzacji kodu przy użyciu odpowiednich narzędzi oraz testów, wykażemy listę zapachów znajdujących się w początkowej wersji kodu oraz doprowadzimy do implementacji zaproponowanych przez nas modyfikacji w kodzie. Przedstawimy również statystyki dotyczące zapachów w kodzie na kilku etapach refaktoryzacji przy użyciu narzędzia RubyCritic.


#### 1. Gra w życie

Gra w życie `The Game of life` jest klasycznym przykładem automatu komórkowego wymyślonego w 1970 r.

Automat komórkowy jest obiektem składającym się z sieci komórek, które posiadają pewien stan z określonego zbioru, oraz algorytmu (zbioru reguł), który określa stan danej komórki, najczęściej w zależności od stanów komórek sąsiednich.

Twórcą `The Game of life` jest John Conway- brytyjski matematyk.  

Gra w życie rozgrywana jest na bardzo dużej kwadratowej planszy reprezentowanej przez macierz nxn. Komórki (elementy) macierzy mogą przyjmować dwie wartości oznaczające odpowiednio: komórkę zamieszkaną (żywą) albo komórkę niezamieszkaną (martwą). Każda komórka ma ośmiu sąsiadów, włączając komórki po przekątnej.

![Warianty gry0](https://i.imgur.com/oXHPd7F.png)
![Warianty gry1](https://i.imgur.com/uAwmpRE.png)
![Warianty gry2](https://i.imgur.com/uAwmpRE.png) 

Rys. Game of life- przykładowe warianty gry.

#### 1.1. Reguły gry

W grze o życie stany komórek zmieniają się w pewnych jednostkach czasu. Stan wszystkich komórek w pewnej jednostce czasu jest używany do obliczenia stanu wszystkich komórek w następnej jednostce. Po obliczeniu wszystkie komórki zmieniają swój stan dokładnie w tym samym momencie. Stan komórki zależy tylko od liczby jej żywych sąsiadów. W grze w życie nie ma graczy w dosłownym tego słowa znaczeniu. Udział człowieka sprowadza się jedynie do ustalenia stanu początkowego komórek.

Reguły gry wg jej twórcy, Johna Conwaya, kształtują się następująco:

1. Każda zamieszkana komórka z trzema lub dwoma sąsiednimi zamieszkanymi komórkami przeżywa (pozostaje zamieszkana) do następnej iteracji.
2. Każda zamieszkana komórka z czterema lub więcej zamieszkanymi sąsiadami ginie (staje się
niezamieszkana) z przeludnienia.
3. Każda zamieszkana komórka z liczbą zamieszkanych sąsiadów mniejszą niż dwa ginie z z nadmiernej izolacji.
4. Każda pusta komórka z trzema zamieszkanymi sąsiadami staje się komórką zamieszkaną.

Jedna iteracja gry polega na przejrzeniu wszystkich komórek w macierzy i zastosowaniu do nich reguł 1-4. Zakładamy że początkowo plansza jest zainicjalizowana jakimś wzorem. np. literą T. Gra odbywa się przez zadaną z góry liczbę iteracji (co najmniej kilkaset). Rozmiar macierzy, sposób inicjalizacji, oraz liczba iteracji są parametrami programu.

![Ewolucja] (https://i.imgur.com/k8DP16N)

Rys. Ewolucja przykładowego układu

Powyższy rysunek obrazuje zależności pomiędzy poszczególnymi sąsiadami, rozpatrzone wg reguł gry z podpunktów 1-4.

Na czerwono oznaczona została żywa komórka, która ma mniej niż dwóch żywych sąsiadów. W następnym kroku będzie ona martwa
Na niebiesko oznaczone zostały żywe komórki mające powyżej trzech sąsiadów. One również zginą.
Na zielono oznaczone zostały komórki mające dokładnie trzech żywych sąsiadów. Zostaną one ożywione
Na czarno oznaczone zostały komórki mające dwóch lub trzech żywych sąsiadów. Stan tych komórek nie zmieni się.

Ostatnia klatka powyższego schematu jest taka sama, jak pierwsza. Takie „zapętlające się” układy nazywane są oscylatorami (1.2. Podział struktur).

#### 1.2. Podział struktur

Struktury mogące pojawić się w trakcie ewolucji schematów dzielimy na kilka głównych kategorii:

- niezmienne
- oscylatory,
- niestałe,
- statki,
- działa,
- puffery.

Struktury niezmienne (stabilne, statyczne), pozostają identyczne bez względu na krok czasowy. 

![Struktury niezmienne](https://i.imgur.com/R2LXeNI)
 
Rys. Przykłady struktur niezmiennych w Grze o życie.

Oscylatory zmieniają się okresowo, co pewien czas powracają do swojego stanu pierwotnego; najprostsza taka struktura składa się z trzech żywych komórek położonych w jednym rzędzie, często pojawiają się jako produkty końcowe ewolucji struktur.
Okresy oscylatorów najczęściej przyjmują wartości 2, 3, 4, 6 lub 8. Zdarzają się też takie, których okres wynosi prawie 150000 (np. „biały rekin”,ma okres 150000034).
Charakterystyczną cechą oscylatorów o dłuższych okresach jest podobieństwo tych o cyklu jednakowej długości.
 
![Oscylatory] (https://i.imgur.com/uMfpEw5)
 
Rys. Przykłady oscylatorów w Grze o życie.

Struktury niestałe zmieniają się, nie powracając nigdy do swojego stanu pierwotnego. Z tego też powodu jest ich najwięcej, a ich uzyskanie nie sprawia większych trudności (losowy układ komórek wprowadzony jako warunki początkowe zwykle okazuje się być strukturą niestałą).Stabilizacją nazywamy zamianę na konfigurację układów stabilnych, oscylatorów i statków (zwykle gliderów). Wartość ta oznaczana będzie tutaj przez L Najważniejsze spośród najprostszych struktur niestałych: R-Pentomino, B-Heptomino, Pi-Heptomino, Bi-Pi-Heptomino, W-Mino.
Odkryto również kilka układów nieśmiertelnych – wykazujących nieskończony wzrost. Podane poniżej ciekawe przykłady po okresie przejściowym tworzą „lokomotywy kładące bloki”. Nieśmiertelny układ – tylko 10 komórek – najmniejsza możliwa ilość, mieści się w kwadracie 5X5.

![Uklad niesmiertelny] (https://i.imgur.com/EdgzZNi)

Rys. Układ nieśmiertelny.

Ogrody Edenu formalnie są strukturami plasującymi się w kategorii niestałych, ale zostały wyróżnione ze względu na swoją szczególną właściwość. Są to bowiem układy, które nie mogą powstać w wyniku ewolucji jakiejkolwiek struktury. Jest ich bardzo niewiele, najmniejszy spośród nich składa się z około 100 komórek.

![Ogrod Edenu](https://i.imgur.com/hJ9VYks)
 
Rys. Najmniejszy znany wzór `ogród Edenu`.

Statki zwykle zmieniają się okresowo – choć okresy nie przekraczają jednak najczęściej kilkunastu kroków czasowych – ale wraz z każdym cyklem przesuwają się o stałą liczbę pól po planszy w określonym kierunku.
Najbardziej znanym przykładem takiej struktury, będącym jednocześnie niejako symbolem gry w życie, jest glider (szybowiec)- układ ten stał się symbolem społeczności hakerskiej. W październiku 2003 roku Eric Raymond zaproponował szybowiec na emblemat hakerski. 
Glider jest najważniejszą strukturą gry w życie- daje mozliwośc tworzenia nowych struktur nawet tych bardzo złożonych, posiada ogromną liczbę struktur (tzw. dział) będących w stanie produkować glidery oraz ma kluczowy udział w niemal każdej strukturze.
 
![Statki](https://i.imgur.com/qaooDOJ)
 
Rys. Przykłady statków oraz glider.

Poza tym znane są także tzw. statki kosmiczne. Wymyślający je informatycy nadają im często artystyczną formę, np. ryby czy falującej wody.

Działa to oscylatory, które co jeden okres „wyrzucają” z siebie jeden statek, który odłącza się i egzystuje samodzielnie. Najwięcej dział generuje glidery, poza tym część jest zdolna do wytwarzania statków kosmicznych. Długość okresu tych struktur waha się od 30 aż do kilkudziesięciu tysięcy kroków czasowych. 

Puffery, inaczej puffer trainy – dymiące pociągi. Struktury oscylujące oraz poruszające się po planszy, a przy tym pozostawiające za sobą cyklicznie inne struktury, które odłączają się i egzystują samodzielnie. Puffera, który zostawia za sobą statki, nazywamy rake'iem. 

Breedery (ang. rozpłodnik, hodowca) natomiast to puffery o bardzo złożonym zachowaniu. Breedery pozostawiają za sobą działa lub nawet inne puffery, jednak jedynym warunkiem określającym czy dany puffer jest breederem, jest kwadratowy przyrost w czasie populacji jego żywych komórek (istnieją też działa wystrzeliwujące „hulaków” i regularne układy z brzegiem zapewniającym im rozszerzanie się).

![Breeder](https://i.imgur.com/fdoSnCg)

Rys. Przykład breeder’a.