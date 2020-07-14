view: dean_orders_2 {
  sql_table_name: demo_db.orders;;

  filter: date_filter {
    label: "Date Range (Limited to 365 days prior to end date)"
    type: date
    default_value: "1 years"
  }

  dimension: date_filter_start_dim {
    hidden: yes
    type: date
    sql: CASE WHEN datediff({% date_end dean_orders_2.date_filter %}, {% date_start dean_orders_2.date_filter %}) > 365 THEN date_sub({% date_end dean_orders_2.date_filter %}, INTERVAL 365 DAY) ELSE {% date_start dean_orders_2.date_filter %} END
    ;;
  }

  dimension: date_filter_end_dim {
    hidden:  yes
    type: date
    sql: {% date_end dean_orders_2.date_filter %};;
  }

  dimension: date_range {
    label: "Date Range"
    description: "Selected range after logic is applied to limit to 365 days"
    type: string
    sql: concat(cast(${date_filter_start_dim} AS CHAR), " - ", cast(${date_filter_end_dim} AS CHAR)) ;;
    html: <div>{{value}}</div> </br>
   <div> Note: filter will only go back maximum 365 days from end date selected!</div>;;
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
  }

  dimension_group: created_nofill {
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
    allow_fill: no
  }

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
