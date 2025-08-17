*----------------------------------------------------------------------*
***INCLUDE ZPRG_MODPOOL5_04_USER_COMMAI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  IF radio_btn1 = 'X'.
    LEAVE TO TRANSACTION 'ZTC1_04'.
  ELSEIF radio_btn2 = 'X'.
    LEAVE TO TRANSACTION 'ZTC2_04'.
  ELSEIF radio_btn3 = 'X'.
    LEAVE TO TRANSACTION 'ZTC3_04'.
  ELSEIF radio_btn4 = 'X'.
    LEAVE TO TRANSACTION 'ZTC4_04'.
  ENDIF.
ENDMODULE.