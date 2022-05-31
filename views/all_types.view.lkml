view: all_types {
  sql_table_name: `looker_test.all_types`
    ;;

  dimension: this_float {
    type: number
    sql: ${TABLE}.this_float ;;
  }

  dimension: this_int {
    type: number
    sql: ${TABLE}.this_int ;;
  }

  dimension: this_string {
    type: string
    sql: ${TABLE}.this_string ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
