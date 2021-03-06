# Zaawansowane języki programowania 17/18

# Projekt na egzamin:
# “ Gra w życie Conway’a – refaktoryzacja kodu w języku Ruby”

#### Grupa “POP”:

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
![Warianty gry2](https://i.imgur.com/FmvwIDn.png) 

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

![Ewolucja](https://i.imgur.com/k8DP16N.png) 

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

![Struktury niezmienne](https://i.imgur.com/R2LXeNI.png) 
 
Rys. Przykłady struktur niezmiennych w Grze o życie.

Oscylatory zmieniają się okresowo, co pewien czas powracają do swojego stanu pierwotnego; najprostsza taka struktura składa się z trzech żywych komórek położonych w jednym rzędzie, często pojawiają się jako produkty końcowe ewolucji struktur.
Okresy oscylatorów najczęściej przyjmują wartości 2, 3, 4, 6 lub 8. Zdarzają się też takie, których okres wynosi prawie 150000 (np. „biały rekin”,ma okres 150000034).
Charakterystyczną cechą oscylatorów o dłuższych okresach jest podobieństwo tych o cyklu jednakowej długości.
 
![Oscylatory](https://i.imgur.com/uMfpEw5.png) 
 
Rys. Przykłady oscylatorów w Grze o życie.

Struktury niestałe zmieniają się, nie powracając nigdy do swojego stanu pierwotnego. Z tego też powodu jest ich najwięcej, a ich uzyskanie nie sprawia większych trudności (losowy układ komórek wprowadzony jako warunki początkowe zwykle okazuje się być strukturą niestałą).Stabilizacją nazywamy zamianę na konfigurację układów stabilnych, oscylatorów i statków (zwykle gliderów). Wartość ta oznaczana będzie tutaj przez L Najważniejsze spośród najprostszych struktur niestałych: R-Pentomino, B-Heptomino, Pi-Heptomino, Bi-Pi-Heptomino, W-Mino.
Odkryto również kilka układów nieśmiertelnych – wykazujących nieskończony wzrost. Podane poniżej ciekawe przykłady po okresie przejściowym tworzą „lokomotywy kładące bloki”. Nieśmiertelny układ – tylko 10 komórek – najmniejsza możliwa ilość, mieści się w kwadracie 5X5.

![Uklad niesmiertelny](https://i.imgur.com/EdgzZNi.png) 

Rys. Układ nieśmiertelny.

Ogrody Edenu formalnie są strukturami plasującymi się w kategorii niestałych, ale zostały wyróżnione ze względu na swoją szczególną właściwość. Są to bowiem układy, które nie mogą powstać w wyniku ewolucji jakiejkolwiek struktury. Jest ich bardzo niewiele, najmniejszy spośród nich składa się z około 100 komórek.

![Ogrod Edenu](https://i.imgur.com/hJ9VYks.png) 
 
Rys. Najmniejszy znany wzór `ogród Edenu`.

Statki zwykle zmieniają się okresowo – choć okresy nie przekraczają jednak najczęściej kilkunastu kroków czasowych – ale wraz z każdym cyklem przesuwają się o stałą liczbę pól po planszy w określonym kierunku.
Najbardziej znanym przykładem takiej struktury, będącym jednocześnie niejako symbolem gry w życie, jest glider (szybowiec)- układ ten stał się symbolem społeczności hakerskiej. W październiku 2003 roku Eric Raymond zaproponował szybowiec na emblemat hakerski. 
Glider jest najważniejszą strukturą gry w życie- daje mozliwośc tworzenia nowych struktur nawet tych bardzo złożonych, posiada ogromną liczbę struktur (tzw. dział) będących w stanie produkować glidery oraz ma kluczowy udział w niemal każdej strukturze.
 
![Statki](https://i.imgur.com/qaooDOJ.png) 
 
Rys. Przykłady statków oraz glider.

Poza tym znane są także tzw. statki kosmiczne. Wymyślający je informatycy nadają im często artystyczną formę, np. ryby czy falującej wody.

Działa to oscylatory, które co jeden okres „wyrzucają” z siebie jeden statek, który odłącza się i egzystuje samodzielnie. Najwięcej dział generuje glidery, poza tym część jest zdolna do wytwarzania statków kosmicznych. Długość okresu tych struktur waha się od 30 aż do kilkudziesięciu tysięcy kroków czasowych. 

Puffery, inaczej puffer trainy – dymiące pociągi. Struktury oscylujące oraz poruszające się po planszy, a przy tym pozostawiające za sobą cyklicznie inne struktury, które odłączają się i egzystują samodzielnie. Puffera, który zostawia za sobą statki, nazywamy rake'iem. 

Breedery (ang. rozpłodnik, hodowca) natomiast to puffery o bardzo złożonym zachowaniu. Breedery pozostawiają za sobą działa lub nawet inne puffery, jednak jedynym warunkiem określającym czy dany puffer jest breederem, jest kwadratowy przyrost w czasie populacji jego żywych komórek (istnieją też działa wystrzeliwujące „hulaków” i regularne układy z brzegiem zapewniającym im rozszerzanie się).

![Breeder](https://i.imgur.com/fdoSnCg.png) 

Rys. Przykład breeder’a.


2. Proces refaktoryzacji


Refaktoryzacja, to zmiana organizacji struktury kodu programu, jednak z zachowaniem integralności jego działania.

Proces ten ułatwia budowę i pielęgnację oprogramowania, umożliwiając utrzymanie systemu komputerowego w stanie pozwalającym na łatwą rozbudowę. Refaktoryzacja jest jednak procesem czasochłonnym i podatnym na błędy, wobec czego pożądana jest jej automatyzacja. Stworzenie niezawodnych i wydajnych narzędzi wspierających programistów w tym zadaniu jest niezbędnym warunkiem do tego, by refaktoryzacja mogła stać się powszechnie przyjętą techniką tworzenia i pielęgnacji programów. 



#### 2.1. Kod

Wybrane repozytorium: (https://github.com/andersondias/conway-game-of-life-ruby)  

Instalacja konfiguracja środowiska
Instalacja Ruby na Ubuntu 16.04.3 LTS
 → ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux] (poprzez rvm),
Instalacja Bundler’a

Konfiguracja Git’a
Powiązanie się z kontem na GitHub’ie,

Instalacja pakietu ruby-reek

Reek to narzędzie, które bada klasy, moduły i metody Ruby, definiuje i raportuje wykryte „zapachy” w kodzie.


![Reek](https://i.imgur.com/a/ScJRE.png)

![Reek](https://i.imgur.com/R4vFerr.png)


Instalacja via rubygems,
Uruchomienie poprzez:  reek -options -dir_or_source_file

![Instalacja Reek'a](https://i.imgur.com/mDPyGLj.png)

#### 2.2. Code smells

Pierwsze testy oraz analiza w narzędziu RubyCritic wykazała występowanie błędów:

![Codesmells](https://i.imgur.com/5ds0h5y.png)


DuplicateMethodCall
FeatureEnvy
HighComplexity
IrresponsibleModule
NestedIterators
PrimaDonnaMethod
TooManyStatements
UncommunicativeParameterName
UncommunicativeVariableName
VeryHighComplexity

#### 2.3. Gemfile

Gemfile to plik, który tworzymy, który służy do opisywania zależności gemów dla programów Ruby. 

Gemfile powinien zawsze znajdować się w katalogu głównym projektu, to jest miejsce, w którym Bundler się tego spodziewa i jest standardowym miejscem do umieszczania plików stylu menedżera pakietów.

Gemfile jest oceniany jako kod Ruby. Kiedy oceniany przez Bundler kontekst, w którym się znajduje, pozwala nam uzyskać dostęp do pewnych metod, które wykorzystujemy do wyjaśnienia naszych wymagań dotyczących gemów.

![Gemfile](https://i.imgur.com/WbTrbVW.png)

#### 2.4. Testy

Do przeprowadzania testów na wybranym przez nas kodzie korzystaliśmy z gotowych, standardowych testów: basic_unit_tests.rb oraz basic_unit_tests.rb.swp 


#### 2.5. RubyCritic

![RubyCritic](https://i.imgur.com/iMZInvs.png)

RubyCritic to narzędzie, które dostarcza raport jakości kodu Ruby (analiza statystyczna gemów, takich jak np. Reek, Flay, Flog etc.)

Instalacja parsera,
Instalacja gem’a RubyCritic,
Instalacja gem’a ffi,
Instalacja gem’a iconv,
gem install churn
Instalacja Bundler’a:
gem install bundler
bundle install
bundle


I. Statystyki kodu przed refaktoryzacją (stan początkowy):

A: 40%
B: 20%
C: 40%

![Statystyka początkowa](https://i.imgur.com/Yy2RJBw.png) 

Wykryte code smells:

![Tabela z wykrytymi code smells](https://i.imgur.com/Kkgg7XO.png) 



II. Statystyki kodu po kilku pierwszych zmianach i eliminacji niektórych zapachów:
A: 50 %
B: 16.67 %
C: 33.33 %

![Statystyka w trakcie](https://i.imgur.com/0IMN4fv.png)
Statystyka po skróceniu case'a- counter_method_give_life_to_neighbours_if_possible += 1 


![Końcowe statystyki](https://i.imgur.com/M2oLxxe.png) 
Końcowe statystyki refaktoryzacji wybranego kodu.

#### 3. Refaktoryzacja - bierzące zmiany w kodzie.

Na początku była ciemność. I nasz kod. Pierwotnie kod miał wiele smelli. 

![smell1](https://i.imgur.com/kI9m19F.png)
![smell2](https://i.imgur.com/nGV8yrg.png)
![smell3](https://i.imgur.com/R5AoOfh.png)

Refaktoryzację rozpoczęłam od usunięcia smelli w pliiku cell.rb. Na pierwszy ogień wzięłam smell Uncommunicative Variable Name. Napisane testy oczywiście przeszły.

![Test](https://i.imgur.com/6vLtDz3.png)

Oczywiście liczba smelli się zmniejszyła w każdym z plików.

![NAME](https://i.imgur.com/LCHOgUq.png)
![wogo](https://i.imgur.com/tML4VT8.png)

Kolejnym krokiem była zmiana attr_accessor na attr_reader. 
Oczywiście i smelle zniknęły i testy przeszły. 

Pozostał jedynie smrodek informujący o powtarzającej się metodzie, który na razie zostawiłam.

![Smell](https://i.imgur.com/QsimFRq.png)

W następnym kroku przeszłam do refaktoryzacji pliku board_console_visualizer.rb. Początkowo plik miał 13 zapachów. 

![13](https://i.imgur.com/NS6iiXl.png)

Udało mi się kilka z nich usunąć. Oczywiście cały czas puszczam testy po każdej zmianie.

![14](https://i.imgur.com/rYiISKW.png)

Utworzenie pliku konfiguracyjnego, w którym zostały zamieszczone pozwolenia na zdublowany kod pozwoliło na usunięcie następnych smelli.

![15](https://i.imgur.com/zZjjUb4.png)
![meh](https://i.imgur.com/rpYIq0f.png)

Następnie do pliku konfiguracyjnego dodałam zapis, który ma ignorować jednoliterowe nazwy iteratorów. Kto widział kod, gdzie iterator jest inny niż i czy j? Jednak reekowi to przeszkadzało. Myślę, że iterator musi mieć taką, a nie inną nazwę, aby kod był czytelny.

Po takich zmianach w kodzie, zostało mi 11 smelli. Oczywiście wciąż wszystkie testy działają.

![iteratory](https://i.imgur.com/kabupjX.png)

Następnie reek wyczuł, że nie jest opisane, co klasa robi. Napisałam więc to.

![komentarz](https://i.imgur.com/d0YTdLM.png)

Następnie zmieniłam attr_accessor na attr_reader.

![atrr](https://i.imgur.com/kElPH2K.png)

Po ostatnich zajęciach, na których byłyśmy jedynie słuchaczami podczas, gdy inne grupy przedstawiały swoje dokonania, które miały za zadanie ułatwienie zrozumienia kodu, z którym pracowali, doszłyśmy do wniosku, że źle podeszłyśmy do problemu refaktoringu. Dlatego też, w tej części, postaramy się popracować z kodem na tyle, aby rzeczywiście był czytelny, a nie, aby tylko "uciszyć" reeka, żeby nie krzyczał o poważnych problemach, które pierwotnie pominęłyśmy. Zdecydowałyśmy się skopiować całe repozytorium, aby pracować z nim dalej oraz, aby tamte "dokonania" były wyraźnie widoczne oraz, aby porównać ostatecznie nasze podejścia. 

Pierwszym, poważnym problemem, z którym miałyśmy do czynienia była funkcja, która miała zbyt skomplikowaną strukturę: smell o nazwie Too Many Statements. Wyglądała ona w ten sposób:

![funkcja](https://i.imgur.com/hIQJYgw.png)

Jak można zauważyć funkcja ta miała również powtarzające się sekcje. Przeniosłam je do nowej, innej funkcji, w której zebrałam powtarzane czynności i po prostu jest ona wywoływana dwukrotnie. Reek oczywiście wyczuł, że wywołuję to samo dwukrotnie, jednak myślę, że w takiej formie jest to bardziej czytelne.

![poprawiona_funkcja](https://i.imgur.com/mPsoV3B.png)

Jeszcze tylko wyświetlenie, czy na pewno smrodek "Too Many Statements" nie występuje.

![smrod](https://i.imgur.com/Hg47uLg.png)

Oczywiście po wprowadzeniu zmian zostały uruhomione testy, które oczywiście przeszły. 

Nastpnym krokiem było zajęcie się ponownie problemem z zbyt wieloma pętlami, zbyt wysokim skomplikowaniem kodu. Również reek tego nie wyczuł, jednak kod był wielokrotnie powielony (praktycznie to samo w każdym z ifów). 

![nieladne_ify](https://i.imgur.com/Vv66mJ1.png)

Zwinęłam ten fragment kodu do podwójnego fora przy wykorzstaniu dwóch tablich po których iteruję - może niezbyt najlepsze rozwiązanie, jednak bardziej czytelne i przyjazne dla oka. 

![piekne_rzeczy](https://i.imgur.com/VJvfS0d.png)

Reek oczywiście dla poprawionego fragmentu kodu nie ma więcej zastrzeżeń. 

![reek](https://i.imgur.com/rKW8nuk.png)

Na podobnej zasadzie pozbyłam się zapachu z fragmentu kodu, który sprawdza czy martwy sąsiad innej komórki może się odrodzić. Jedynie martwe komórki posiadające 3 sąsiadów mogą odrodzić się na nowo. Wykorzystana w tym fragmencie konstrukcja case-when była dość rozwlekła. "Zwinęłam" ją do poniższego rozwiązania:
![case](https://i.imgur.com/28oUUy0.png) 
