#KOL
#maja

using LinearAlgebra;

#1) Przedstaw w postaci maszynowej
#typu Int64 o wartości 9223372036854775808 (jeśli korzystasz z komputera 64 bit)
#Wyjaśnij ewentualne problemy
#Liczba ta nie mieści się w typie Int64, gdyż największa liczba jaka mieści się w tym typie to 9223372036854775807. Liczba 9223372036854775808 jest o jeden większa niż maksymalna dopuszczalna liczba w formacie Int64. Aby przedstawić ją w postaci maszynowej trzeba zapisać te liczbę w formacie Int128. 

#=
print("Maksymalna liczba dla typu Int64: ")
println(typemax(Int64))

liczba=Int128(9223372036854775808)
println(liczba)
print("Maszynowe przedstawienie liczby: ")
println(bitstring(liczba))

#ewentualne problemy mogą wynikać z tego, iż podana liczba znajduje się poza zakresem liczb przechowywanych przez typ Int64.

=#

#2) Jak duży błąd względny popełniamy tutaj w obliczeniach i dlaczego on się pojawia?
# Problem pojawia się, gdyż liczby są sprowadzane do wspólnej (unormowanej) postaci naukowej. Podczas odejmowania liczb pojawia się problmem z dokładnoścą ich reprezentacji. Dzieje się tak, gdy liczba jest poza zakresem dokładności dla danego typu. 
#Błąd względny wynosi 100%

#=
x1=0.9*1e17
println(typeof(x1))
x2=-1
println(typeof(x2))

println(eps(Float64))


x=0.9*1e17 - 1 - 0.9*1e17 # dla komputera 64 bit
println(x)
x_poprawka=9*1e16-9*1e16-1
println(x_poprawka)
=#

#=
#3) 

function newtonMethod(f, fpochodna, x0, maxIter, delta, err)

    #zmienna do iterowania po pętli
    i = 0

    y = f(x0)

    if abs(y) <= err
        return ("Miejsce zerowe: $x0");
    end

    while i < maxIter

        y = f(x0)
        ypochodne = fpochodna(x0)

        if ypochodne == 0
            return ("Dzielenie przez zero");
        end
        
        xn1 = x0 - (y / ypochodne)

        if abs(xn1 - x0) <= delta
            return ("Miejsce zerowe: $xn1");
        end

        #xn+1 w następnej iteeracji stanie się xn
        x0 = xn1

        #następna iteracja
        i = i + 1
    end
    return ("Problem ze zbieżnością");

end 

#3a)Znajdź miejsca zerowe funkcji dla warunków początkowych X0={2,1,0,-1}.

f(x)=x^3-x^2-x
f_pochodna(x)=3*x^2-2*x-1

maxIter=1000
delta=0.0001
err=0.001

println("Dla x0=2: "*newtonMethod(f,f_pochodna,2,maxIter,delta, err))
println("Dla x0=1: "*newtonMethod(f,f_pochodna,1,maxIter,delta, err))
println("Dla x0=0: "*newtonMethod(f,f_pochodna,0,maxIter,delta, err))
println("Dla x0=-1: "*newtonMethod(f,f_pochodna,-1,maxIter,delta, err))

#3b) Wyjaśnij problemy ze zbieżnością, korzystając w pojęć matematycznych.
#Problem ze zbieżnością mogą pojawić się, gdy w danym punkcie pochodna funkcji jest równa 0. Taki problem pojawił się dla x0=1, i dla tego warunku początkowego niemożliwe jest znalezienie rozwiązania (z powodu pochodnej, która w tym punkcie jest równa 0)

=#

#4) Metoda iteracji funkcyjnych dla układu jednowymiarowego

#=
function banach(f, x, maxIter, err)
    #zmienna do iterowania po pętli
    i = 0;
    #pętla do liczenia
    while i < maxIter
        x1 = f(x);

        #Gdy x zbiega do nieskończoności (lub -nieskończoności)
        if x1 == Inf || x1 == -Inf
            return ("Błąd zbieżności ");
        end

        #sprawdzenie czy x jest już miejscem zerowym
        if abs(x1 - x) < err
            return ("Miejsce zerowe: $x");
        end
        #zamiana aby x1 było w nastepnej iteracji x
        x = x1;
        i = i + 1;
    end
    return ("Błąd zbieżności")
end

#Dane
#f(x)=x^3-x^2-x    x=x^3-x^2 /+x=> 2x=x^3-x^2+x  =>  x=(x^3-x^2+x)/2
f(x)=(x^3-x^2+x)/2
maxIter=10000
err=0.00001

#4a)Znajdź miejsca zerowe funkcji dla warunków początkowych X0={2,1,0,-1}.
println("Dla x0=2: "*banach(f,2,maxIter,err))
println("Dla x0=1: "*banach(f,1,maxIter,err))
println("Dla x0=0: "*banach(f,0,maxIter,err))
println("Dla x0=-1: "*banach(f,-1,maxIter,err))
=#

#4b)Wyjaśnij problemy ze zbieżnością, korzystając w pojęć matematycznych.
#W zależności jak zostanie przekształcona oryginalna funkcja, metoda może zbiegać wolno, szybko lub wcale. Problemy mogą pojawić się też, gdy źle zostanie wybrany punkt początkowy. W tym przypadku dla punktu początkowego x0-2 i x0=-1 metoda nie zbiega
#4c)Podaj warunki dla tego przypadku, dla których algorytm oparty na metodzie iteracji funkcyjnych na pewno zbiegnie do rozwiązania (jeśli w #ogóle takie warunki tutaj są). Uzasadnij swoją odpowiedź, korzystając z pojęć matematycznych.
#Aby uzyskać zbieżność w metodzie Banacha potrzeba punktu stałego w kontrakcji w danym przedziale, w tym przypadku takim punktem jest x=0 gdyż dla tej wartości spełniony jest warunek f(x)=x, czyli f(0)=0 (Innym takim punktem dla tego przedziału będzie też -1 lub 2)




#=
#5) Metoda Doolittle

function doolittle(n, A)
    # n - wymiar macierzy
    # A - macierz wspołczynników równania liniowego

    #tworzy macierz z 1 na przekątnych i zarami poza przekątną
    L = one(zeros(n, n))
    #macierz wypełniona zerami
    U = zeros(n, n)

    #Główna pętla iterująca po k
    for k in 1:n
        #Pętla iterująca po j
        for j in k:n
            #specjalny warunek aby nie wyjśc poza zakres, gdyż w Julii indeksowanie od 1
            if (k == 1)
                U[k, j] = A[k, j]
            else
                #obliczanie wartoci elementu w macierzy górnotrójkątnej
                U[k, j] = A[k, j] - sum(L[k, s] * U[s, j] for s in 1:(k-1))
            end
        end

        for i in (k+1):n
            if (k == 1)
                if U[k, k] == 0
                    return ("Dzielenie przez 0!")
                end
                L[i, k] = A[i, k] / U[k, k]
            else
                if U[k, k] == 0
                    return ("Dzielenie przez 0!")
                end
                L[i, k] = (A[i, k] - sum(L[i, s] * U[s, k] for s in 1:(k-1))) / U[k, k]
            end
        end

    end
    #zwracane są dwie macierze - górno i dolno trójkątna
    return [L, U]
end

#5a) Znajdź rozkład na czynniki macierzy współczynników A, B i C.
A=[0.5 1 1.5;1 2 3; 0.25 0.5 3/4]
B=[-1 3 -2;4 3 -1;8 3 1]
C=[0 1/3 1.5;1 0.5 3; 1.5 1 -0.5]

println("Wyznaczniki macierzy: ")
println(det(A))
println(det(B))
println(det(C))
n=3

println("Rozkład macierzy A:")
println(doolittle(n,A))

println("Rozkład macierzy B:")
println(doolittle(n,B))

println("Rozkład macierzy C:")
println(doolittle(n,C))

#5b) Wyjaśnij problemy, korzystając w pojęć matematycznych.
#Problem pojawi się dla macierzy A, gdyż aby móc rozłożyć macierz na czynniki musi być ona odwracalna, a aby dało się ją odwrócić wyznacznik macierzy musi być różny od 0. W tym przypadku macierz A ma wyznacznik równy 0 i dlatego pojawia się problem. 
#Problem pojawił się także dla macierzy C, gdyż wystąpiło dzielenie przez 0. W algorytmie tym istnieje ryzyko dzielenia przez 0, co proawdzi do niepoprawnych wyników. Użyłam instrukcji if, aby wyłapać wcześniej dzielenie przez 0 i wyświetlić opowiedni komunikat

=###########################

#=
using LinearAlgebra

function zadanie1()
    println(bitstring(9223372036854775808))
    # Ciąg bitów nie jest poprawny, ponieważ podana liczba nie mieści się w zakresie obsługiwanym przez Int64 (jest o 1 za duża)
    # Ten ciąg bitów opisuje najmniejszą możliwą do zapisania w Int64 liczbę.
end
#zadanie1()

function zadanie2()
    x=0.9*1e17 - 1 - 0.9*1e17
    println(x)
    # Popełniamy błąd względny = abs(-1 - 0) = 1
    # Pojawia się, ponieważ odejmowanie bardzo małych liczb od bardzo dużych skutkuje niedokładnością
    # ze względu na naturę typu zmiennoprzecinkowego
end
#zadanie2()
function metoda_stycznych(f, f_pochodna, x0, delta, maxiterations, err)
    tmp = f(x0)
    if abs(tmp) <= err
        return x0
    end

    for i in 1:maxiterations
        x1 = x0 - (f(x0) / f_pochodna(x0))
        if (abs(x1 - x0) <= delta)
            return x1
        end
        x0 = x1
    end 
    return "Problem ze zbieżnością"
end

function zadanie3()
    f(x) = x^3-x^2-x
    f_p(x) = 3*x^2-2*x-1
    println(metoda_stycznych(f, f_p, 2.0, 0.00001, 10000, 0.00001))
    println(metoda_stycznych(f, f_p, 1.0, 0.00001, 10000, 0.00001))
    println(metoda_stycznych(f, f_p, 0.0, 0.00001, 10000, 0.00001))
    println(metoda_stycznych(f, f_p, -1.0, 0.00001, 10000, 0.00001))
    # Jest problem ze zbieżnością dla x=1. Funkcja musi w tym punkcie mieć pochodną poziomą (y=const)
end
#zadanie3()

function banach(f, x0, maxiter, err)
    i = 0
    while i < maxiter
        x1 = f(x0)
        if abs(x1 - x0) < err
            return x0
        end
        x0 = x1
        i = i + 1
    end
    return ("Błąd zbieżności")
end

function zadanie4()
    f(x)=x^3-x^2-x
    f_(x) = x^3-x^2
    println(banach(f_, 2.0, 10000, 0.00001))
    println(banach(f_, 1.0, 10000, 0.00001))
    println(banach(f_, 0.0, 10000, 0.00001))
    println(banach(f_, -1.0, 10000, 0.00001))
    # Nie udało się osiągnąć zbieżności dla x=2 i x=-1.
    # Wynika to z faktu, że funkcja w tych punktach nie spełnia mapowania kontrakcyjnego
    # (pochodna w tych punktach jest mniejsza niż 1)
end
#zadanie4()
function doolittle(n,A)
    L = one(zeros(n, n))
    U = zeros(n, n)
    for k in 1:n
        for j in k:n
            if (k == 1)
                U[k, j] = A[k, j]
            else
                U[k, j] = A[k, j] - sum(L[k, s]*U[s, j] for s in 1:(k-1) )
            end
        end
        for i in (k+1) : n
            if (k==1)
                L[i, k] = A[i, k] / U[k, k]
            else
                L[i, k] = (A[i, k] - sum(L[i, s]*U[s, k] for s in 1:(k-1))) / U[k, k]
            end
        end
    end
    return [L U]
end
function zadanie5()
    A=[0.5 1 1.5;1 2 3; 0.25 0.5 3/4]
    B=[-1 3 -2;4 3 -1;8 3 1]
    C=[0 1/3 1.5;1 0.5 3; 1.5 1 -0.5]
    display(doolittle(3, A))
    display(doolittle(3, B))
    display(doolittle(3, C))
    # W macierzach A i C pojawiły się wartości Nan i Inf, więc wyniki są nieprawidłowe.
    # Wynika to z faktu, że przynajmniej jeden z minorów głównych tych macierzy ma wyznacznik równy 0
    # W przypadku macierzy A to jest minor:
    # 0.5 1
    # 1 2
    # W przypadku macierzy C to jest minor:
    # 0

end
zadanie5()
=#