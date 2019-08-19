view: zozo_table_20190507 {
  sql_table_name: demo_db.zozo_table_20190507 ;;

  dimension: users_count {
    type: number
    sql: ${TABLE}.`users.count` ;;
  }

  dimension_group: users_created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`users.created_date` ;;
  }

  dimension: users_first_name {
    type: string
    sql: ${TABLE}.`users.first_name` ;;
  }

  dimension: users_last_name {
    type: string
    sql: ${TABLE}.`users.last_name` ;;
  }

  measure: count {
    type: count
    drill_fields: [users_last_name, users_first_name]
  }
}
