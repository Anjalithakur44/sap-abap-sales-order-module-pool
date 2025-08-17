*----------------------------------------------------------------------*
***INCLUDE ZPRG_MODPOOL2_04_USER_COMMAI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  IF sy-ucomm = 'DISPLAY'.
    SELECT ono odate pm ta curr
      FROM zordh_04
      INTO TABLE lt_data
      WHERE ono = zordh_04-ono.

    READ TABLE lt_data INTO lwa_data INDEX 1.

    IF sy-subrc = 0.
      zordh_04-odate = lwa_data-odate.
      zordh_04-pm = lwa_data-pm.
      zordh_04-ta = lwa_data-ta.
      zordh_04-curr = lwa_data-curr.
    ENDIF.

    IF lt_data IS NOT INITIAL.
      SELECT ono oino odesc icost
      FROM zordit_04
      INTO TABLE lt_data1
      FOR ALL ENTRIES IN lt_data
      WHERE ono = lt_data-ono.
    ENDIF.
  ENDIF.
  IF sy-ucomm = 'HEADER'.
    CALL SCREEN '0300'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.