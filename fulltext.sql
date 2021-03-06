--Wyszukiwanie pełnotekstowe

--Usługa Full-Text Search pozwala znacznie przyspieszyć i ułatwić wyszukiwanie w dużych polach typu CHAR, VARCHAR, TEXT lub BINARY. Oferuje znacznie większą wydajność i funkcjonalność niż standardowy operator LIKE. Usługa ta przyda się więc przede wszystkim przy tworzeniu różnego rodzaju wyszukiwarek działających w aplikacjach operujących na dużych polach tekstowych.

--Aby skorzystać z wyszukiwania pełnotekstowego, należy upewnić się, że na serwerze włączona jest usługa SQL Server FullText Search. Następnie należy włączyć opcję wyszukiwania pełnotekstowego dla wybranej bazy danych, pisząc:

--sp_fulltext_database 'enable'

--Tabela, na której chcemy użyć tej opcji, musi mieć założony unikalny indeks na kolumnie niedopuszczającej NULL. Może być to indeks zakładany domyślnie na kluczu głównym. Dla każdej bazy danych, w której chcemy użyć wyszukiwania pełnotekstowego, musimy założyć tzw. katalog (Catalog). Opcję tworzenia katalogów znajdziemy w Management Studio w gałęzi Storage i Full Text Catalogs. Katalog jest to po prostu plik dyskowy, w którym serwer przechowuje dane dotyczące indeksów pełnotekstowych. Tworząc katalog, musimy wskazać lokalizację pliku. Możemy podać również grupę plików (Filegroup) podobnie jak w przypadku innych plików bazy danych.

--Po utworzeniu katalogu możemy dodawać do niego indeksy pełnotekstowe, wchodząc we właściwości katalogu i wskazując tabele i kolumny, które mają być indeksowane. Czynność tę można również wykonać przy pomocy kreatora dostępnego po wybraniu opcji Define Full-Text Index na wybranej tabeli.

--Najczęściej używane funkcje pozwalające na wykorzystanie indeksu pełnotekstowego to:

--CONTAINS(kolumna, 'wyraz') – zwraca logiczną wartość "prawda", gdy w dowolnym miejscu w polu znajduje się szukany wyraz.

--FREETEXT(kolumna, 'treść') – zwraca logiczną wartość "prawda", gdy co najmniej jeden z szukanych wyrazów znajdzie się w polu, niezależnie od kolejności.

--Przykład użycia:

--SELECT * FROM wiadomosc WHERE CONTAINS(tresc, 'wyraz')

--Istnieją również funkcje zwracające wynik w postaci tabeli wraz z rankingiem trafności: CONTAINSTABLE i FREETEXTTABLE. Przykład użycia:

--SELECT * FROM wiadomosc INNER JOIN CONTAINSTABLE(wiadomosc, tresc, 'wyraz') AS wynik on wiadomosc.idwiadomosc = wynik.[key]

--Bardzo istotną kwestią przy używaniu indeksów pełnotekstowych jest sposób ich aktualizowania. W przypadku dużych pól tekstowych i częstych aktualizacji tabeli, każdorazowe przebudowanie indeksu może być kosztowne i znacznie obciążać serwer. Dlatego możliwe jest ustawienie, przy którym indeks będzie przebudowywany na podstawie harmonogramu lub ręcznie. Trzeba pamiętać jednak, że w tym przypadku zapytania używające funkcji wykorzystujących indeks pełnotekstowy mogą zwracać nieaktualne wyniki. Dostępne są trzy sposoby aktualizacji indeksu:

--    Całkowite (Full) – buduje indeks od początku, może być bardzo czasochłonne.
--    Przyrostowe (Incremental) – wymaga, aby w tabeli była założona kolumna typu Timestamp.
--    Aktualizacyjne (Update) – wymaga włączonej opcji śledzenia zmian (Change Tracking).

--Ustawienia dotyczące aktualizacji indeksów pełnotekstowych oraz tworzenia harmonogramów znajdziemy po wybraniu opcji Full-Text index, a następnie Properties na danej tabeli.