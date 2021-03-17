view: dean_orders_2 {
  sql_table_name: demo_db.orders ;;

  # parameter: field_selector {
  #   type: unquoted
  #   allowed_value: {label: "ID"    value: "${TABLE}.id" }
  #   allowed_value: {label: "USER ID"  value: "${TABLE}.user_id" }
  #   allowed_value: {label: "STATUS"    value: "${TABLE}.status"   }
  # }

  # dimension: flex_field {
  #   type:  string
  #   sql:  {% parameter field_selector %} ;;
  # }
  dimension: id_2 {
    type: string
    sql: ${TABLE}.id ;;
    tags: ["phone"]
  }

  parameter: date_time_selector {
    type: date_time
  }

  dimension: phone_number {
    type: string
    sql: "+1 607 351 2292" ;;
    tags: ["phone"]
  }

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



  dimension: date_start {
    type: date
    sql: date({% date_start created_time %}) ;;
  }

  dimension: date_end {
    type: date
    sql: date({% date_end created_time %}) ;;
  }

  dimension: date_diff {
    type: number
    sql: datediff(${date_end},${date_start}) ;;
  }

  dimension: dynamic_date {
    type: date
    sql: CASE WHEN datediff(date({% date_end created_time %}),date({% date_start created_time %})) >= 90
          THEN date(date_format(${created_date}, "%Y-%m-01"))
          ELSE
          ${created_date}
          END;;
  }

  parameter: date_filter_selector {
    type: date
    suggest_dimension: orders_2.created_date
  }

  measure: count_selected_date {
    type: count_distinct
    sql: CASE WHEN (date({% parameter date_filter_selector %}) = ${created_date}) THEN ${id} ELSE NULL end ;;
  }

  measure: count_prior_date {
    type: count_distinct
    sql: CASE WHEN (date(dateadd({% parameter date_filter_selector %}, INTERVAL -7 DAY)) = ${created_date}) THEN ${id} else NULL end ;;
  }

  # dimension_group: created_nofill {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.created_at ;;
  #   allow_fill: no
  # }

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
    allowed_value: {label: "orders_2" value:"dean_orders_2"}
    allowed_value: {label: "order_items" value:"order_items"}
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
    html:
    <b><p style="text-align:center">
    {% if value == 'cancelled' %}
    🚫
    {% elsif value == 'complete' %}
    👍
    {% elsif value == 'pending' %}
    🤷
    {% endif %}
    {{ value }} </p></b>;;
  }

  measure: distinct_users {
    type: count_distinct
    sql: ${user_id};;
    required_access_grants: [can_see_sensitive_data_only]
  }


  measure: orders_per_user {
    type: number
    sql: ${count}/${distinct_users} ;;
    value_format_name: decimal_4
  }

  # measure: distinct_items {
  #   type: count_distinct
  #   sql: {% assign view = view._parameter_value %}
  #   {{ "${" | append: view | append: ".id}" }};;

  # }
  # sql: ${order_items.inventory_item_id};;

  dimension: user_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.user_id ;;
    tags: ["user_id"]
  }

  parameter: measure_picker {
    type: unquoted
    allowed_value: { value: "count_complete" }
    allowed_value: { value: "orders_per_user" }
  }

  measure: dynamic_measure {
    type: number
    sql: {% if measure_picker._parameter_value == "count_complete" %}
            ${count_complete}
          {% elsif measure_picker._parameter_value == "orders_per_user" %}
            ${orders_per_user}
          {% else %}
            null
          {% endif %}  ;;
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
    value_format_name: decimal_1
  }

  measure: raw_count {
    type: number
    sql: count(*) ;;
  }

  measure: list_status {
    type: string
    sql: group_concat(distinct ${status}) ;;
  }

  ### For use with sql_always_where in limited_orders explore ###

  parameter: user_id_parameter {
    type: string
    suggest_explore: limited_orders_suggest
    suggest_dimension: limited_orders_suggest.user_id
  }

}
