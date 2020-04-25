*"* use this source file for your ABAP unit test classes
CLASS ltc_gol DEFINITION
DURATION SHORT
RISK LEVEL HARMLESS
FOR TESTING.

  PUBLIC SECTION.

    DATA: cut TYPE REF TO ycl_gol_cell.

    METHODS:
      lv_less_then_two,
      lv_two_or_three,
      lv_more_then_three,
      dead_exactly_three FOR TESTING.

ENDCLASS.

CLASS ltc_gol IMPLEMENTATION.

  METHOD dead_exactly_three.

    cut = NEW #( is_alive = abap_false ).

    DO 3 TIMES.
      DATA(lo_living_cell) = NEW ycl_gol_cell( is_alive = abap_true ).
      cut->add_neighbour( io_cell = lo_living_cell ).
    ENDDO.

    DO 5 TIMES.
      DATA(lo_dead_cell) = NEW ycl_gol_cell( is_alive = abap_false ).
      cut->add_neighbour( io_cell = lo_dead_cell ).
    ENDDO.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = cut->is_alive
        exp                  = abap_true
*        ignore_hash_sequence = abap_false
*        tol                  =
*        msg                  =
*        level                = if_abap_unit_constant=>severity-medium
*        quit                 = if_abap_unit_constant=>quit-test
*      RECEIVING
*        assertion_failed     =
    ).



  ENDMETHOD.

  METHOD lv_less_then_two.

  ENDMETHOD.

  METHOD lv_more_then_three.

  ENDMETHOD.

  METHOD lv_two_or_three.

  ENDMETHOD.

ENDCLASS.
