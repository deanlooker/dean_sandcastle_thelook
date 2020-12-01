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
    sql: CASE WHEN datediff({% date_end date_filter %}, {% date_start date_filter %}) > 365 THEN date_sub({% date_end date_filter %}, INTERVAL 365 DAY) ELSE {% date_start date_filter %} END
    ;;
  }

  dimension: date_filter_end_dim {
    hidden:  yes
    type: date
    sql: {% date_end date_filter %};;
  }

  dimension: date_range {
    label: "Date Range"
    description: "Selected range after logic is applied to limit to 365 days"
    type: string
    sql: concat(cast(${date_filter_start_dim} AS CHAR), " - ", cast(${date_filter_end_dim} AS CHAR)) ;;
    html: <div>{{value}}</div> </br>
   <div> Note: filter will only go back maximum 365 days from end date selected!</div>;;
  }


  dimension: last_id {
    type: number
    sql: (SELECT ${TABLE}.id
      FROM ${TABLE}
      ORDER BY ${TABLE}.created_at DESC
      LIMIT 1)
      ;;
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
      week_of_year,
      year
    ]
    sql: ${TABLE}.created_at ;;
    datatype: timestamp
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
    type: string
    suggest_dimension: status
  }

  parameter: view {
    type: unquoted
    allowed_value: {value:"dean_orders_2"}
    allowed_value: {value:"order_items"}
  }



  measure: most_recent {
    type: date_time
    sql: max(${created_date}) ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date,day_of_week,month,month_name,month_num,year,time]
    sql: SELECT min(created_at) from demo_db.orders where user_id = ${user_id} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_id};;
    required_access_grants: [can_see_sensitive_data_only]
  }


  measure: orders_per_user {
    type: number
    sql: ${count}/${distinct_users} ;;
  }

  measure: distinct_items {
    type: count_distinct
    sql: {% assign view = view._parameter_value %}
     {{ "${" | append: view | append: ".id}" }};;

  }
  # sql: ${order_items.inventory_item_id};;

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    tags: ["user_id"]
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }

  dimension: is_complete {
    type: yesno
    sql: ${status} = "complete" ;;
  }

  measure: count_complete {
    type: count
    filters: [status: "complete"]
  }

  measure: raw_count {
    type: number
    sql: count(*) ;;
  }

  ### For use with sql_always_where in limited_orders explore ###

  parameter: user_id_parameter {
    type: string
    suggest_explore: limited_orders_suggest
    suggest_dimension: limited_orders_suggest.user_id
  }

}
