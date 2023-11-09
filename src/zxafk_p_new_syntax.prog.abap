*&---------------------------------------------------------------------*
*& Report ZXAFK_P_NEW_SYNTAX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zxafk_p_new_syntax.

TYPES :BEGIN OF ty_first,
         werks  TYPE werks_d,
         arbpl  TYPE arbpl,
         toplam TYPE menge_d,
         meins  TYPE meins,
         islem  TYPE int8,
       END OF ty_first.

TYPES : tt_first TYPE TABLE OF ty_first WITH EMPTY KEY.

DATA(lt_first) = VALUE tt_first(
  ( werks = '2013' arbpl = '07' toplam = '16'   meins = '' )
  ( werks = '2013' arbpl = '07' toplam = '32'   meins = '' )
  ( werks = '2015' arbpl = '09' toplam = '07'   meins = '' ) ).

DATA(lt_itab) = VALUE tt_first(
FOR GROUPS groups OF ls_grp IN lt_first
GROUP BY ( werks = ls_grp-werks arbpl = ls_grp-arbpl )
ASCENDING
(
werks = groups-werks
arbpl = groups-arbpl
toplam = REDUCE menge_d( INIT x = 0 FOR wa IN lt_first WHERE ( werks = groups-werks AND arbpl = groups-arbpl ) NEXT x = x + wa-toplam )
meins  = CONV meins( LET lv_meins = 'ADT' IN lv_meins )
islem  = CONV int8( LET lv_carp1 = 5 lv_carp2 = 3 IN ( lv_carp1 * lv_carp2 ) )
) ).

BREAK-POINT.

*DATA itab TYPE TABLE OF i WITH NON-UNIQUE KEY table_line.
*
*DATA(rnd) = cl_abap_random_int=>create( seed = + sy-uzeit
*                                         min  = 1
*                                         max  = 10 ).
*
*itab = VALUE #( FOR i = 1 UNTIL i > 10 ( rnd->get_next( ) ) ).
*
*DATA jtab LIKE itab.
*jtab = VALUE #( FOR GROUPS <fs> OF wa IN itab
*                    INDEX INTO i
*                    GROUP BY wa
*                    ASCENDING
*                ( i - <fs> ) ).
*
*cl_demo_output=>display( jtab ).


*LOOP AT lt_first INTO DATA(ls_first) GROUP BY ( werks = ls_first-werks arbpl = ls_first-arbpl ) INTO DATA(lg_grp) .
**  LOOP AT GROUP lg_grp INTO DATA(ls_group).
*
*  APPEND VALUE #( werks  = lg_grp-werks
*                  arbpl  = lg_grp-arbpl
*                  toplam = REDUCE i( INIT x = 0 FOR wa IN lt_first WHERE ( werks = lg_grp-werks AND arbpl = lg_grp-arbpl ) NEXT x += wa-toplam )
*                  meins  = CONV meins( LET lv_meins = 'ADT' IN lv_meins )
*                  islem  =
*) TO lt_itab.
**  ENDLOOP.
*ENDLOOP.


*SELECT * FROM spfli INTO TABLE @DATA(spfli).
*
*TYPES group_keys TYPE STANDARD TABLE OF spfli-carrid WITH EMPTY KEY.
*
*DATA(lt_itab2) =
*  VALUE group_keys(
*    FOR GROUPS carrier OF wa IN spfli
*    GROUP BY wa-carrid
*    ASCENDING
*    WITHOUT MEMBERS
*    ( carrier ) ) .





*TYPES:
*  BEGIN OF date,
*    year  TYPE c LENGTH 4,
*    month TYPE c LENGTH 2,
*    day   TYPE c LENGTH 2,
*  END OF date,
*  dates TYPE TABLE OF date WITH EMPTY KEY.
*DATA(dates) = VALUE dates(
**  ( year = '2013' month = '07' day = '16' )
**  ( year = '2014' month = '08' day = '31' )
* ( year = '2015' month = '09' day = '07' ) ).
*DO lines( dates ) TIMES.
*  DATA(isodate) = CONV string(
*     LET <date>  = dates[ sy-index ] sep   =   '-'
*      IN <date>-year && sep && <date>-month && sep && <date>-day  ).
*  cl_demo_output=>write( isodate ).
*ENDDO.
*cl_demo_output=>display( ).
