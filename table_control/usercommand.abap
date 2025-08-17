*----------------------------------------------------------------------*
***INCLUDE ZPRG_MODPOOL1_04_USER_COMMAI01.
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
      INTO TABLE lt_data1
      WHERE ono = zordh_04-ono.

    IF lt_data1 IS NOT INITIAL.
      SELECT ono oino odesc icost
        FROM zordit_04
        INTO TABLE lt_data2
        FOR ALL ENTRIES IN lt_data1
        WHERE ono = lt_data1-ono.
    ENDIF.
    READ TABLE lt_data1 INTO lwa_data1 INDEX 1.
    IF sy-subrc = 0.
      zordh_04-odate = lwa_data1-odate.
      zordh_04-pm = lwa_data1-pm.
      zordh_04-ta = lwa_data1-ta.
      zordh_04-curr = lwa_data1-curr.
    ENDIF.
  ENDIF.
  IF sy-ucomm = 'HEADER'.
    CALL SCREEN '0200'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CALL SCREEN '0100'.
ENDMODULE.