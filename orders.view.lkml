view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      hour_of_day,
      time,
      date,
      day_of_week,
      week_of_year,
      month,
      month_name,
      quarter,
      year,
      day_of_month
    ]
    sql: ${TABLE}.created_at ;;
  }


  measure: max_created {
    type: max
    sql: ${created_time} ;;
    html: {{ rendered_value | date: "%B %e, %Y" }} ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: <center>{{value}}</center> ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.id, users.last_name, order_items.count]
  }

  measure: iframe_test {
    type: yesno
    sql: 1==1 ;;
    html: <iframe src="https://docs.google.com/forms/d/e/1FAIpQLScouygCcXNj8oFhB7biaiz2sIu_Kz25zc3oa7XRLghYYB5Dag/viewform?embedded=true" width="640" height="445" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe> ;;
  }
}
