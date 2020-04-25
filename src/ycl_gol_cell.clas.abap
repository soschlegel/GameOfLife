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
ENDCLASS.



CLASS ycl_gol_cell IMPLEMENTATION.

  METHOD constructor.

    me->is_alive = is_alive.

  ENDMETHOD.

  METHOD add_neighbour.

    APPEND io_cell TO neighbours.

  ENDMETHOD.

  METHOD is_cell_alive.

    IF is_alive EQ abap_false.

      is_alive = boolc( REDUCE i( INIT result = 0
                           FOR lo_neighbour IN neighbours
                           WHERE ( table_line->is_alive EQ abap_true )
                           NEXT result = result + 1 ) EQ 3 ).


  ELSE.


    ENDIF.





  ENDMETHOD.

ENDCLASS.
