view: dean_orders {
  sql_table_name: (select * from demo_db.orders where status = 'complete');;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id_lol ;;
  }

  filter: test_filter {
    group_label: "2. filters"
    type: date
  }

  filter: filter_test {
    group_label: "2. filters"
    type: string
  }

  filter: aah_real_filters {
    group_label: "1. params"
    type: string
  }

  #testing lol


  dimension_group: created_and_Stuff {
    type: time
    sql: ${TABLE}.created_at ;;
    drill_fields: [users.country]
  }

  dimension_group: created_content_val_test {
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

  # measure: most_recent {
  #   type:  date
  #   sql: max(${created_date}) ;;
  # }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    suggest_dimension: suggests.status_suggest
    suggest_explore: suggests
  }

  parameter: schema {
    type: unquoted
    allowed_value: {value: "demo_db"}
    allowed_value: {value: "breaky"}
  }




  measure: distinct_users {
    type: count_distinct
    sql: ${user_id};;
  }

#   measure: distinct_items {
#     type: count_distinct
#     sql: ${order_items.inventory_item_id};;
#   }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    tags: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  }

explore: suggests {
  join: dean_orders {}
}

view: suggests {
  sql_table_name: {% parameter dean_orders.schema %}.orders ;;
dimension: status_suggest {
  hidden: yes
  sql: (SELECT status FROM ${suggests.SQL_TABLE_NAME});;
}
}
