view: dean_orders_2 {
  sql_table_name: demo_db.orders;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  parameter: limit_num {
    type: number
  }

  parameter: date_param {
    type: date
  }

  parameter: filter_param {
    type: unquoted
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
    drill_fields: [users.country]
  }

  measure: most_recent {
    type:  date
    sql: max(${created_date}) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_id};;
  }

  measure: distinct_items {
    type: count_distinct
    sql: ${order_items.inventory_item_id};;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

}
