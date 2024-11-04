% Base de conocimiento para almacenar tareas
:- dynamic tarea/5.  % tarea(ID, Descripcion, FechaLimite, Estado, Importancia)

% Predicado para leer una línea de texto
leer_texto(Texto) :-
    read_line_to_string(user_input, Texto).

% Predicado para limpiar el buffer de entrada
limpiar_buffer :-
    read_line_to_string(user_input, _).

% Predicado para agregar una nueva tarea
agregar_tarea(ID, Descripcion, FechaLimite, Importancia) :-
    (Importancia >= 1, Importancia =< 5 ->
        assert(tarea(ID, Descripcion, FechaLimite, pendiente, Importancia))
    ;
        writeln('Error: El nivel de importancia debe estar entre 1 y 5')).

% Predicado para marcar una tarea como completada
completar_tarea(ID) :-
    retract(tarea(ID, Desc, Fecha, pendiente, Imp)),
    assert(tarea(ID, Desc, Fecha, completada, Imp)).

% Predicado para eliminar una tarea
eliminar_tarea(ID) :-
    retract(tarea(ID, _, _, _, _)).

% Predicado para convertir fecha a término comparable
fecha_a_termino(Fecha, Termino) :-
    atomic_list_concat([Anio, Mes, Dia], '-', Fecha),
    atom_number(Anio, A),
    atom_number(Mes, M),
    atom_number(Dia, D),
    Termino = date(A, M, D).

% Predicado para ordenar tareas por urgencia y prioridad
ordenar_tareas(TareasOrdenadas) :-
    findall(tarea(ID, Desc, Fecha, Estado, Imp), 
            tarea(ID, Desc, Fecha, Estado, Imp), 
            Tareas),
    include(es_pendiente, Tareas, TareasPendientes),
    predsort(comparar_tareas, TareasPendientes, TareasOrdenadas).

% Predicado auxiliar para verificar si una tarea está pendiente
es_pendiente(tarea(_, _, _, pendiente, _)).

% Predicado para comparar tareas
comparar_tareas(Orden, 
                tarea(ID1, _, Fecha1, _, Imp1), 
                tarea(ID2, _, Fecha2, _, Imp2)) :-
    fecha_a_termino(Fecha1, T1),
    fecha_a_termino(Fecha2, T2),
    (T1 = T2 ->
        (Imp1 = Imp2 -> 
            compare(Orden, ID1, ID2)
        ;
            compare(Orden, Imp2, Imp1))
    ;
        compare(Orden, T1, T2)).

% Predicado para listar todas las tareas
listar_tareas :-
    writeln('\nLista de Tareas:'),
    writeln('ID | Descripción | Fecha Límite | Estado | Importancia'),
    writeln('---------------------------------------------------'),
    forall(tarea(ID, Desc, Fecha, Estado, Imp),
           format('~w | ~w | ~w | ~w | ~w~n', [ID, Desc, Fecha, Estado, Imp])).

% Predicado para listar tareas pendientes ordenadas
listar_pendientes :-
    writeln('\nTareas Pendientes (Ordenadas por urgencia e importancia):'),
    writeln('ID | Descripción | Fecha Límite | Importancia'),
    writeln('---------------------------------------------------'),
    ordenar_tareas(TareasOrdenadas),
    mostrar_tareas_ordenadas(TareasOrdenadas).

% Predicado auxiliar para mostrar tareas ordenadas
mostrar_tareas_ordenadas([]).
mostrar_tareas_ordenadas([tarea(ID, Desc, Fecha, _, Imp)|Resto]) :-
    format('~w | ~w | ~w | ~w~n', [ID, Desc, Fecha, Imp]),
    mostrar_tareas_ordenadas(Resto).

% Predicado para buscar tareas por descripción
buscar_tarea(Palabra) :-
    writeln('\nResultados de la búsqueda:'),
    forall((tarea(ID, Desc, Fecha, Estado, Imp), sub_string(Desc, _, _, _, Palabra)),
           format('~w | ~w | ~w | ~w | ~w~n', [ID, Desc, Fecha, Estado, Imp])).

% Menú principal
menu :-
    writeln('\nOrganizador de Tareas'),
    writeln('1. Agregar tarea'),
    writeln('2. Marcar tarea como completada'),
    writeln('3. Eliminar tarea'),
    writeln('4. Listar todas las tareas'),
    writeln('5. Listar tareas pendientes (ordenadas)'),
    writeln('6. Buscar tarea'),
    writeln('0. Salir'),
    write('Seleccione una opción: '),
    read(Opcion),
    limpiar_buffer,
    procesar_opcion(Opcion).

% Procesamiento de opciones del menú
procesar_opcion(1) :-
    write('ID de la tarea (número): '), 
    read(ID),
    limpiar_buffer,
    write('Descripción: '), 
    leer_texto(Desc),
    write('Fecha límite (AAAA-MM-DD): '), 
    leer_texto(Fecha),
    write('Importancia (1-5): '), 
    read(Imp),
    limpiar_buffer,
    agregar_tarea(ID, Desc, Fecha, Imp),
    menu.

procesar_opcion(2) :-
    write('ID de la tarea a completar: '), 
    read(ID),
    limpiar_buffer,
    completar_tarea(ID),
    menu.

procesar_opcion(3) :-
    write('ID de la tarea a eliminar: '), 
    read(ID),
    limpiar_buffer,
    eliminar_tarea(ID),
    menu.

procesar_opcion(4) :-
    listar_tareas,
    menu.

procesar_opcion(5) :-
    listar_pendientes,
    menu.

procesar_opcion(6) :-
    write('Palabra a buscar: '), 
    leer_texto(Palabra),
    buscar_tarea(Palabra),
    menu.

procesar_opcion(0) :-
    writeln('¡Hasta luego!').

% Iniciar el programa
inicio :- menu.