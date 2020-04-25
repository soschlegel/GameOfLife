*"* use this source file for your ABAP unit test classes
CLASS ltc_gol DEFINITION
DURATION SHORT
RISK LEVEL HARMLESS
FOR TESTING.

  PUBLIC SECTION.

    DATA: cut TYPE REF TO ycl_gol_cell.

    METHODS:
      create_neighbours
        IMPORTING
          dead   TYPE i
          living TYPE i,
      lv_less_then_two FOR TESTING,
      lv_two_or_three FOR TESTING,
      lv_more_then_three FOR TESTING,
      dead_exactly_three FOR TESTING,
      dead_not_exactly_three FOR TESTING.

ENDCLASS.

CLASS ltc_gol IMPLEMENTATION.

  METHOD dead_exactly_three.

    cut = NEW #( is_alive = abap_false ).

    create_neighbours( dead   = 5
                       living = 3 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = cut->is_cell_alive( )
        exp                  = abap_true ).

  ENDMETHOD.

  METHOD lv_less_then_two.



  ENDMETHOD.

  METHOD lv_more_then_three.

  ENDMETHOD.

  METHOD lv_two_or_three.

    cut = NEW #( is_alive = abap_true ).

    create_neighbours( dead   = 4
                       living = 3 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = cut->is_cell_alive( )
        exp                  = abap_true ).

    cut = NEW #( is_alive = abap_true ).

    create_neighbours( dead   = 6
                       living = 2 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = cut->is_cell_alive( )
        exp                  = abap_true ).


  ENDMETHOD.

  METHOD create_neighbours.

    DO living TIMES.
      DATA(lo_living_cell) = NEW ycl_gol_cell( is_alive = abap_true ).
      cut->add_neighbour( io_cell = lo_living_cell ).
    ENDDO.

    DO dead TIMES.
      DATA(lo_dead_cell) = NEW ycl_gol_cell( is_alive = abap_false ).
      cut->add_neighbour( io_cell = lo_dead_cell ).
    ENDDO.


  ENDMETHOD.

  METHOD dead_not_exactly_three.

    cut = NEW #( is_alive = abap_false ).

    create_neighbours( dead   = 5
                       living = 2 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = cut->is_cell_alive( )
        exp                  = abap_false ).

  ENDMETHOD.

ENDCLASS.
