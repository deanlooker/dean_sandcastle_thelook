view: fatal_error_persist_for_five_seconds {
  sql_table_name: `looker_test.FATAL_ERROR_persist_for_five_seconds`
    ;;

  dimension: user_count {
    type: number
    sql: ${TABLE}.user_count ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
