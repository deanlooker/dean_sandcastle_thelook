view: dean_orders {
  sql_table_name: demo_db.orders;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
