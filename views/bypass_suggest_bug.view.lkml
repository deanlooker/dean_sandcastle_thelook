explore: test {
  sql_always_where: ${test.month} = "January" OR ${test.month} = "February" ;;
}

view:  test {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status  ;;
    suggest_persist_for: "0 minutes"
    bypass_suggest_restrictions: yes
  }

  # dimension: suggest_status {
  #   type: string
  #   sql: ${TABLE}.status  ;;
  #   suggest_persist_for: "0 minutes"
  # }


  dimension: month {
    type: string
    sql: monthname(${TABLE}.created_at) ;;
    bypass_suggest_restrictions: yes
    suggest_persist_for: "0 minutes"
  }

  # dimension: suggest_month {
  #   type: string
  #   sql: monthname(${TABLE}.created_at) ;;
  #   suggest_persist_for: "0 minutes"
  # }

  measure: count {
    type: count
  }

}
