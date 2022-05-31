view: swett_del {
  sql_table_name: `looker_test.swett_del`
    ;;

  dimension_group: orders_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.orders_created_date ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.orders_status ;;
  }

  dimension: orders_the_count {
    type: number
    sql: ${TABLE}.orders_the_count ;;
  }

  dimension: orders_the_count0 {
    type: number
    sql: ${TABLE}.orders_the_count0 ;;
  }

  dimension: orders_the_count__hll {
    type: string
    sql: ${TABLE}.orders_the_count__hll ;;
  }

  dimension: users_age {
    type: number
    sql: ${TABLE}.users_age ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
