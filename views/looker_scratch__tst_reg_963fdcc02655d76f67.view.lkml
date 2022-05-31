view: looker_scratch__tst_reg_963fdcc02655d76f67 {
  sql_table_name: `looker_test.looker_scratch__tst_reg_963fdcc02655d76f67`
    ;;

  dimension: created_at {
    type: number
    sql: ${TABLE}.created_at ;;
  }

  dimension: expires_at {
    type: number
    sql: ${TABLE}.expires_at ;;
  }

  dimension: looker {
    type: string
    sql: ${TABLE}.looker ;;
  }

  dimension: reg_key {
    type: string
    sql: ${TABLE}.reg_key ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
