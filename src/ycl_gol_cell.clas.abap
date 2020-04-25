CLASS ycl_gol_cell DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
           tab TYPE STANDARD TABLE OF REF TO ycl_gol_cell WITH DEFAULT KEY.


    DATA:
      is_alive   TYPE abap_bool READ-ONLY,
      neighbours TYPE tab.

    METHODS:
      add_neighbour
        IMPORTING
          io_cell TYPE REF TO ycl_gol_cell,
      constructor
        IMPORTING
          is_alive TYPE abap_bool,
      is_cell_alive
        RETURNING
          VALUE(is_alive) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS count_living_neighbours
      RETURNING
        VALUE(r_result) TYPE i.
ENDCLASS.



CLASS ycl_gol_cell IMPLEMENTATION.

  METHOD constructor.

    me->is_alive = is_alive.

  ENDMETHOD.

  METHOD add_neighbour.

    APPEND io_cell TO neighbours.

  ENDMETHOD.

  METHOD is_cell_alive.

    IF me->is_alive EQ abap_false.

      is_alive = boolc( count_living_neighbours( ) EQ 3 ).

    ELSE.

      is_alive = COND #( LET living_neighbours =
                            count_living_neighbours( )
                          IN WHEN living_neighbours EQ 2
                                OR living_neighbours EQ 3
                              THEN abap_true ).

    ENDIF.

    me->is_alive = is_alive.

  ENDMETHOD.

  METHOD count_living_neighbours.

    r_result = REDUCE i( INIT result = 0
                           FOR lo_neighbour IN neighbours
                           WHERE ( table_line->is_alive EQ abap_true )
                           NEXT result = result + 1 ).
  ENDMETHOD.

ENDCLASS.
