CLASS zcl_task_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA : out TYPE REF TO if_oo_adt_classrun_out.
    METHODS
      populate_ztask_with_test_data.
    METHODS
      empty_ztask_data.
ENDCLASS.



CLASS zcl_task_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    me->out = out.
    me->empty_ztask_data( ).
    me->populate_ztask_with_test_data(  ).
  ENDMETHOD.

  METHOD populate_ztask_with_test_data.
    DATA lt_task TYPE STANDARD TABLE OF ztask.
    DATA ls_task TYPE ztask.


    DO 500 TIMES.
      DATA(system_uuid) = cl_uuid_factory=>create_system_uuid( ).
      TRY.
          DATA(lv_uuid) = system_uuid->create_uuid_c32( ).
          out->write(
            EXPORTING
              data = lv_uuid
*             name =
*            RECEIVING
*             output =
          ).
          ls_task = VALUE #(
          taskid      = lv_uuid
          title       = |Task { sy-index }|
          description = |Task { sy-index } description| ).
          APPEND ls_task TO lt_task.
          IF sy-subrc <> 0.
            out->write( 'fail to insert' ).
            CONTINUE.
          ENDIF.
        CATCH cx_uuid_error.
          cl_demo_output=>display( 'fail' ).
          CONTINUE.
      ENDTRY.
*      LOOP AT lt_task INTO ls_task.
*        out->write( ls_task-taskid ).
*      ENDLOOP.
*      out->write( lt_task ).
    ENDDO.
    INSERT ztask FROM TABLE lt_task.
  ENDMETHOD.

  METHOD empty_ztask_data.
    DELETE FROM ztask.
    COMMIT WORK.
  ENDMETHOD.

ENDCLASS.
