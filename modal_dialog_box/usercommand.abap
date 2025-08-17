*----------------------------------------------------------------------*
***INCLUDE ZPRG_MODPOOL3_04_USER_COMMAI01.
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
    CALL SCREEN '0200' STARTING AT 9 19 "TOP LEFT CORNER COORDINATES
                          ENDING AT 50 60. "BOTTOM RIGHT CORNER COOORDINATES
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  IF sy-ucomm = 'OK'.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDMODULE.