        xor esi, esi

    azzero :
        mov[mat3 + esi * 4], 0     //azzero la matrice risultato
        inc esi
        mov eax, m
        imul eax, k
        cmp esi, eax
        jl azzero

        xor edi, edi    //azzero edi
        xor ecx, ecx    //azzero ecx
        xor esi, esi    //azzero esi


        cmp n, 1        //controllo se mat1 contiene solo un elemento
        jne secondocontrollo
        cmp m, 1
        jne secondocontrollo

    unoperunomat1 :
        movsx eax, [mat1]       //in caso le moltiplico semplicemente
        movsx ebx, [mat2 + edi * 2]
        imul eax, ebx
        add[mat3 + ecx * 4], eax
        inc edi
        inc ecx
        cmp edi, k
        jl unoperunomat1

        jmp fine

    secondocontrollo :      //controllo se mat2 è 1x1
        cmp k, 1
        jne inizio
        cmp n, 1
        ja inizio

    unoperunomat2 :
        movsx eax, [mat1 + edi * 2]       //in caso le moltiplico semplicemente anche qui
        movsx ebx, [mat2]
        imul eax, ebx
        add[mat3 + ecx * 4], eax
        inc edi
        inc ecx
        cmp edi, m
        jl unoperunomat2
        jmp fine

    inizio :
        xor esi, esi    // azzero esi
        xor edi, edi    // azzero edi
        xor ecx, ecx    // azzero ecx
        xor edx, edx    //azzero edx
        jmp ciclo1      //vado al ciclo del prodotto

    cambiorigamat3 :     //azzero i seguenti counter per cambiare riga correttamente
        xor edi, edi
        xor edx, edx

    azzeroedx :          //azzero il counter dei prodotti eseguiti
        xor edx, edx

    ciclo1 :

        movsx eax, [mat1 + esi * 2]     //assegno a eax i valori delle righe di mat1
        movsx ebx, [mat2 + edi * 2]     //assegno a ebx i valori delle righe di mat2
        imul eax, ebx                   //moltiplico
        add[mat3 + ecx * 4], eax       //aggiungo il risultato alla posizione corretta
        inc edi                         //vado avanti in mat2
        inc ecx                         //vado avanti in mat3
        inc edx                         //counter dei prodotti eseguiti
        cmp edx, k                      //controllo se ho eseguito tutti i prodotti della riga
        jl ciclo1

        inc esi                             //vado avanti in mat1
        mov edx, k                          //controllo se ho eseguito tutti i k*n prodotti
        imul edx, n
        cmp edi, edx
        je cambiorigamat3                   //in quel caso comincio a stampare alla riga sotto

        sub ecx, k                          //sennò rimando il puntatore di mat3 alla prima posizione
        mov edx, m
        imul edx, n
        cmp esi, edx                        //controllo se ho fatto tutti gli m*n calcoli
        jl azzeroedx                        //in caso contrario ritorno al ciclo

    fine :
