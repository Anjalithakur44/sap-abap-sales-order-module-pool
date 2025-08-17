*&---------------------------------------------------------------------*
*& Modulpool ZPRG_MODPOOL3_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM ZPRG_MODPOOL3_04.
TABLES: ZORDH_04.

TYPES: BEGIN OF LTY_DATA,
  ONO TYPE ZDEONO_04,
  ODATE TYPE ZDEODATE_04,
  PM TYPE ZDEPM_04,
  TA TYPE ZDETC_04,
  CURR TYPE ZDECUR_04,
  END OF LTY_DATA.

DATA: LT_DATA TYPE TABLE OF LTY_DATA,
      LWA_DATA TYPE LTY_DATA.

INCLUDE zprg_modpool3_04_user_commai01.