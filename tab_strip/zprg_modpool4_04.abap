*&---------------------------------------------------------------------*
*& Modulpool ZPRG_MODPOOL4_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zprg_modpool4_04.

TABLES: zordh_04.

TYPES: BEGIN OF lty_data1,
         ono   TYPE zdeono_04,
         odate TYPE zdeodate_04,
         pm    TYPE zdepm_04,
         ta    TYPE zdetc_04,
         curr  TYPE zdecur_04,
       END OF lty_data1.
DATA: lt_data1  TYPE TABLE OF lty_data1,
      lwa_data1 TYPE lty_data1.

TYPES: BEGIN OF lty_data2,
         ono   TYPE zdeono_04,
         oino  TYPE zdeorditno_04,
         odesc TYPE zdeorddesc_04,
         icost TYPE zdeorditcost_04,
       END OF lty_data2.
DATA: lt_data2  TYPE TABLE OF lty_data2,
      lwa_data2 TYPE lty_data2.


*&SPWIZARD: FUNCTION CODES FOR TABSTRIP 'ZORDER_TBS1_04'
CONSTANTS: BEGIN OF c_zorder_tbs1_04,
             tab1 LIKE sy-ucomm VALUE 'ZORDER_TBS1_04_FC1',
             tab2 LIKE sy-ucomm VALUE 'ZORDER_TBS1_04_FC2',
           END OF c_zorder_tbs1_04.
*&SPWIZARD: DATA FOR TABSTRIP 'ZORDER_TBS1_04'
CONTROLS:  zorder_tbs1_04 TYPE TABSTRIP.
DATA: BEGIN OF g_zorder_tbs1_04,
        subscreen   LIKE sy-dynnr,
        prog        LIKE sy-repid VALUE 'ZPRG_MODPOOL4_04',
        pressed_tab LIKE sy-ucomm VALUE c_zorder_tbs1_04-tab1,
      END OF g_zorder_tbs1_04.
DATA:      ok_code LIKE sy-ucomm.

*&SPWIZARD: OUTPUT MODULE FOR TS 'ZORDER_TBS1_04'. DO NOT CHANGE THIS LI
*&SPWIZARD: SETS ACTIVE TAB
MODULE zorder_tbs1_04_active_tab_set OUTPUT.
  zorder_tbs1_04-activetab = g_zorder_tbs1_04-pressed_tab.
  CASE g_zorder_tbs1_04-pressed_tab.
    WHEN c_zorder_tbs1_04-tab1.
      g_zorder_tbs1_04-subscreen = '0101'.
    WHEN c_zorder_tbs1_04-tab2.
      g_zorder_tbs1_04-subscreen = '0102'.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TS 'ZORDER_TBS1_04'. DO NOT CHANGE THIS LIN
*&SPWIZARD: GETS ACTIVE TAB
MODULE zorder_tbs1_04_active_tab_get INPUT.
  ok_code = sy-ucomm.
  CASE ok_code.
    WHEN c_zorder_tbs1_04-tab1.
      g_zorder_tbs1_04-pressed_tab = c_zorder_tbs1_04-tab1.
    WHEN c_zorder_tbs1_04-tab2.
      g_zorder_tbs1_04-pressed_tab = c_zorder_tbs1_04-tab2.
    WHEN OTHERS.
*&SPWIZARD:      DO NOTHING
  ENDCASE.
ENDMODULE.

*&SPWIZARD: DECLARATION OF TABLECONTROL 'ZORDER_TC4_04' ITSELF
CONTROLS: ZORDER_TC4_04 TYPE TABLEVIEW USING SCREEN 0102.

*&SPWIZARD: LINES OF TABLECONTROL 'ZORDER_TC4_04'
DATA:     G_ZORDER_TC4_04_LINES  LIKE SY-LOOPC.

*&SPWIZARD: OUTPUT MODULE FOR TC 'ZORDER_TC4_04'. DO NOT CHANGE THIS LIN
*&SPWIZARD: UPDATE LINES FOR EQUIVALENT SCROLLBAR
MODULE ZORDER_TC4_04_CHANGE_TC_ATTR OUTPUT.
  DESCRIBE TABLE LT_DATA2 LINES ZORDER_TC4_04-lines.
ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'ZORDER_TC4_04'. DO NOT CHANGE THIS LIN
*&SPWIZARD: GET LINES OF TABLECONTROL
MODULE ZORDER_TC4_04_GET_LINES OUTPUT.
  G_ZORDER_TC4_04_LINES = SY-LOOPC.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TC 'ZORDER_TC4_04'. DO NOT CHANGE THIS LINE
*&SPWIZARD: PROCESS USER COMMAND
MODULE ZORDER_TC4_04_USER_COMMAND INPUT.
  OK_CODE = SY-UCOMM.
  PERFORM USER_OK_TC USING    'ZORDER_TC4_04'
                              'LT_DATA2'
                              ' '
                     CHANGING OK_CODE.
  SY-UCOMM = OK_CODE.
ENDMODULE.

*----------------------------------------------------------------------*
*   INCLUDE TABLECONTROL_FORMS                                         *
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  USER_OK_TC                                               *
*&---------------------------------------------------------------------*
 FORM USER_OK_TC USING    P_TC_NAME TYPE DYNFNAM
                          P_TABLE_NAME
                          P_MARK_NAME
                 CHANGING P_OK      LIKE SY-UCOMM.

*&SPWIZARD: BEGIN OF LOCAL DATA----------------------------------------*
   DATA: L_OK              TYPE SY-UCOMM,
         L_OFFSET          TYPE I.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

*&SPWIZARD: Table control specific operations                          *
*&SPWIZARD: evaluate TC name and operations                            *
   SEARCH P_OK FOR P_TC_NAME.
   IF SY-SUBRC <> 0.
     EXIT.
   ENDIF.
   L_OFFSET = STRLEN( P_TC_NAME ) + 1.
   L_OK = P_OK+L_OFFSET.
*&SPWIZARD: execute general and TC specific operations                 *
   CASE L_OK.
     WHEN 'INSR'.                      "insert row
       PERFORM FCODE_INSERT_ROW USING    P_TC_NAME
                                         P_TABLE_NAME.
       CLEAR P_OK.

     WHEN 'DELE'.                      "delete row
       PERFORM FCODE_DELETE_ROW USING    P_TC_NAME
                                         P_TABLE_NAME
                                         P_MARK_NAME.
       CLEAR P_OK.

     WHEN 'P--' OR                     "top of list
          'P-'  OR                     "previous page
          'P+'  OR                     "next page
          'P++'.                       "bottom of list
       PERFORM COMPUTE_SCROLLING_IN_TC USING P_TC_NAME
                                             L_OK.
       CLEAR P_OK.
*     WHEN 'L--'.                       "total left
*       PERFORM FCODE_TOTAL_LEFT USING P_TC_NAME.
*
*     WHEN 'L-'.                        "column left
*       PERFORM FCODE_COLUMN_LEFT USING P_TC_NAME.
*
*     WHEN 'R+'.                        "column right
*       PERFORM FCODE_COLUMN_RIGHT USING P_TC_NAME.
*
*     WHEN 'R++'.                       "total right
*       PERFORM FCODE_TOTAL_RIGHT USING P_TC_NAME.
*
     WHEN 'MARK'.                      "mark all filled lines
       PERFORM FCODE_TC_MARK_LINES USING P_TC_NAME
                                         P_TABLE_NAME
                                         P_MARK_NAME   .
       CLEAR P_OK.

     WHEN 'DMRK'.                      "demark all filled lines
       PERFORM FCODE_TC_DEMARK_LINES USING P_TC_NAME
                                           P_TABLE_NAME
                                           P_MARK_NAME .
       CLEAR P_OK.

*     WHEN 'SASCEND'   OR
*          'SDESCEND'.                  "sort column
*       PERFORM FCODE_SORT_TC USING P_TC_NAME
*                                   l_ok.

   ENDCASE.

 ENDFORM.                              " USER_OK_TC

*&---------------------------------------------------------------------*
*&      Form  FCODE_INSERT_ROW                                         *
*&---------------------------------------------------------------------*
 FORM fcode_insert_row
               USING    P_TC_NAME           TYPE DYNFNAM
                        P_TABLE_NAME             .

*&SPWIZARD: BEGIN OF LOCAL DATA----------------------------------------*
   DATA L_LINES_NAME       LIKE FELD-NAME.
   DATA L_SELLINE          LIKE SY-STEPL.
   DATA L_LASTLINE         TYPE I.
   DATA L_LINE             TYPE I.
   DATA L_TABLE_NAME       LIKE FELD-NAME.
   FIELD-SYMBOLS <TC>                 TYPE CXTAB_CONTROL.
   FIELD-SYMBOLS <TABLE>              TYPE STANDARD TABLE.
   FIELD-SYMBOLS <LINES>              TYPE I.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

   ASSIGN (P_TC_NAME) TO <TC>.

*&SPWIZARD: get the table, which belongs to the tc                     *
   CONCATENATE P_TABLE_NAME '[]' INTO L_TABLE_NAME. "table body
   ASSIGN (L_TABLE_NAME) TO <TABLE>.                "not headerline

*&SPWIZARD: get looplines of TableControl                              *
   CONCATENATE 'G_' P_TC_NAME '_LINES' INTO L_LINES_NAME.
   ASSIGN (L_LINES_NAME) TO <LINES>.

*&SPWIZARD: get current line                                           *
   GET CURSOR LINE L_SELLINE.
   IF SY-SUBRC <> 0.                   " append line to table
     L_SELLINE = <TC>-LINES + 1.
*&SPWIZARD: set top line                                               *
     IF L_SELLINE > <LINES>.
       <TC>-TOP_LINE = L_SELLINE - <LINES> + 1 .
     ELSE.
       <TC>-TOP_LINE = 1.
     ENDIF.
   ELSE.                               " insert line into table
     L_SELLINE = <TC>-TOP_LINE + L_SELLINE - 1.
     L_LASTLINE = <TC>-TOP_LINE + <LINES> - 1.
   ENDIF.
*&SPWIZARD: set new cursor line                                        *
   L_LINE = L_SELLINE - <TC>-TOP_LINE + 1.

*&SPWIZARD: insert initial line                                        *
   INSERT INITIAL LINE INTO <TABLE> INDEX L_SELLINE.
   <TC>-LINES = <TC>-LINES + 1.
*&SPWIZARD: set cursor                                                 *
   SET CURSOR 1 L_LINE.

 ENDFORM.                              " FCODE_INSERT_ROW

*&---------------------------------------------------------------------*
*&      Form  FCODE_DELETE_ROW                                         *
*&---------------------------------------------------------------------*
 FORM fcode_delete_row
               USING    P_TC_NAME           TYPE DYNFNAM
                        P_TABLE_NAME
                        P_MARK_NAME   .

*&SPWIZARD: BEGIN OF LOCAL DATA----------------------------------------*
   DATA L_TABLE_NAME       LIKE FELD-NAME.

   FIELD-SYMBOLS <TC>         TYPE cxtab_control.
   FIELD-SYMBOLS <TABLE>      TYPE STANDARD TABLE.
   FIELD-SYMBOLS <WA>.
   FIELD-SYMBOLS <MARK_FIELD>.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

   ASSIGN (P_TC_NAME) TO <TC>.

*&SPWIZARD: get the table, which belongs to the tc                     *
   CONCATENATE P_TABLE_NAME '[]' INTO L_TABLE_NAME. "table body
   ASSIGN (L_TABLE_NAME) TO <TABLE>.                "not headerline

*&SPWIZARD: delete marked lines                                        *
   DESCRIBE TABLE <TABLE> LINES <TC>-LINES.

   LOOP AT <TABLE> ASSIGNING <WA>.

*&SPWIZARD: access to the component 'FLAG' of the table header         *
     ASSIGN COMPONENT P_MARK_NAME OF STRUCTURE <WA> TO <MARK_FIELD>.

     IF <MARK_FIELD> = 'X'.
       DELETE <TABLE> INDEX SYST-TABIX.
       IF SY-SUBRC = 0.
         <TC>-LINES = <TC>-LINES - 1.
       ENDIF.
     ENDIF.
   ENDLOOP.

 ENDFORM.                              " FCODE_DELETE_ROW

*&---------------------------------------------------------------------*
*&      Form  COMPUTE_SCROLLING_IN_TC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_TC_NAME  name of tablecontrol
*      -->P_OK       ok code
*----------------------------------------------------------------------*
 FORM COMPUTE_SCROLLING_IN_TC USING    P_TC_NAME
                                       P_OK.
*&SPWIZARD: BEGIN OF LOCAL DATA----------------------------------------*
   DATA L_TC_NEW_TOP_LINE     TYPE I.
   DATA L_TC_NAME             LIKE FELD-NAME.
   DATA L_TC_LINES_NAME       LIKE FELD-NAME.
   DATA L_TC_FIELD_NAME       LIKE FELD-NAME.

   FIELD-SYMBOLS <TC>         TYPE cxtab_control.
   FIELD-SYMBOLS <LINES>      TYPE I.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

   ASSIGN (P_TC_NAME) TO <TC>.
*&SPWIZARD: get looplines of TableControl                              *
   CONCATENATE 'G_' P_TC_NAME '_LINES' INTO L_TC_LINES_NAME.
   ASSIGN (L_TC_LINES_NAME) TO <LINES>.


*&SPWIZARD: is no line filled?                                         *
   IF <TC>-LINES = 0.
*&SPWIZARD: yes, ...                                                   *
     L_TC_NEW_TOP_LINE = 1.
   ELSE.
*&SPWIZARD: no, ...                                                    *
     CALL FUNCTION 'SCROLLING_IN_TABLE'
          EXPORTING
               ENTRY_ACT             = <TC>-TOP_LINE
               ENTRY_FROM            = 1
               ENTRY_TO              = <TC>-LINES
               LAST_PAGE_FULL        = 'X'
               LOOPS                 = <LINES>
               OK_CODE               = P_OK
               OVERLAPPING           = 'X'
          IMPORTING
               ENTRY_NEW             = L_TC_NEW_TOP_LINE
          EXCEPTIONS
*              NO_ENTRY_OR_PAGE_ACT  = 01
*              NO_ENTRY_TO           = 02
*              NO_OK_CODE_OR_PAGE_GO = 03
               OTHERS                = 0.
   ENDIF.

*&SPWIZARD: get actual tc and column                                   *
   GET CURSOR FIELD L_TC_FIELD_NAME
              AREA  L_TC_NAME.

   IF SYST-SUBRC = 0.
     IF L_TC_NAME = P_TC_NAME.
*&SPWIZARD: et actual column                                           *
       SET CURSOR FIELD L_TC_FIELD_NAME LINE 1.
     ENDIF.
   ENDIF.

*&SPWIZARD: set the new top line                                       *
   <TC>-TOP_LINE = L_TC_NEW_TOP_LINE.


 ENDFORM.                              " COMPUTE_SCROLLING_IN_TC

*&---------------------------------------------------------------------*
*&      Form  FCODE_TC_MARK_LINES
*&---------------------------------------------------------------------*
*       marks all TableControl lines
*----------------------------------------------------------------------*
*      -->P_TC_NAME  name of tablecontrol
*----------------------------------------------------------------------*
FORM FCODE_TC_MARK_LINES USING P_TC_NAME
                               P_TABLE_NAME
                               P_MARK_NAME.
*&SPWIZARD: EGIN OF LOCAL DATA-----------------------------------------*
  DATA L_TABLE_NAME       LIKE FELD-NAME.

  FIELD-SYMBOLS <TC>         TYPE cxtab_control.
  FIELD-SYMBOLS <TABLE>      TYPE STANDARD TABLE.
  FIELD-SYMBOLS <WA>.
  FIELD-SYMBOLS <MARK_FIELD>.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

  ASSIGN (P_TC_NAME) TO <TC>.

*&SPWIZARD: get the table, which belongs to the tc                     *
   CONCATENATE P_TABLE_NAME '[]' INTO L_TABLE_NAME. "table body
   ASSIGN (L_TABLE_NAME) TO <TABLE>.                "not headerline

*&SPWIZARD: mark all filled lines                                      *
  LOOP AT <TABLE> ASSIGNING <WA>.

*&SPWIZARD: access to the component 'FLAG' of the table header         *
     ASSIGN COMPONENT P_MARK_NAME OF STRUCTURE <WA> TO <MARK_FIELD>.

     <MARK_FIELD> = 'X'.
  ENDLOOP.
ENDFORM.                                          "fcode_tc_mark_lines

*&---------------------------------------------------------------------*
*&      Form  FCODE_TC_DEMARK_LINES
*&---------------------------------------------------------------------*
*       demarks all TableControl lines
*----------------------------------------------------------------------*
*      -->P_TC_NAME  name of tablecontrol
*----------------------------------------------------------------------*
FORM FCODE_TC_DEMARK_LINES USING P_TC_NAME
                                 P_TABLE_NAME
                                 P_MARK_NAME .
*&SPWIZARD: BEGIN OF LOCAL DATA----------------------------------------*
  DATA L_TABLE_NAME       LIKE FELD-NAME.

  FIELD-SYMBOLS <TC>         TYPE cxtab_control.
  FIELD-SYMBOLS <TABLE>      TYPE STANDARD TABLE.
  FIELD-SYMBOLS <WA>.
  FIELD-SYMBOLS <MARK_FIELD>.
*&SPWIZARD: END OF LOCAL DATA------------------------------------------*

  ASSIGN (P_TC_NAME) TO <TC>.

*&SPWIZARD: get the table, which belongs to the tc                     *
   CONCATENATE P_TABLE_NAME '[]' INTO L_TABLE_NAME. "table body
   ASSIGN (L_TABLE_NAME) TO <TABLE>.                "not headerline

*&SPWIZARD: demark all filled lines                                    *
  LOOP AT <TABLE> ASSIGNING <WA>.

*&SPWIZARD: access to the component 'FLAG' of the table header         *
     ASSIGN COMPONENT P_MARK_NAME OF STRUCTURE <WA> TO <MARK_FIELD>.

     <MARK_FIELD> = SPACE.
  ENDLOOP.
ENDFORM.                                          "fcode_tc_mark_lines

INCLUDE zprg_modpool4_04_user_commai01.