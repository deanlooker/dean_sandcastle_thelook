# If necessary, uncomment the line below to include explore_source.
# include: "dean_test.model.lkml"

view: orders_by_state_dt {
  derived_table: {
    explore_source: dean_orders_2 {
      column: state { field: users.state }
      # column: created_month { field: dean_orders_2.created_month }
      column: count_dim { field: dean_orders_2.count }
      filters: {
        field: dean_orders_2.created_date
        value: "2018/01/01 to 2018/12/31"
      }
    }
  }
  dimension: state {}
  # dimension: created_month {
  #   type: date_month
  # }
  dimension: count_dim {
    type: number
  }

  dimension: state_count_tier {
    case: {
      when: {
        sql: ${count_dim} < 100;;
        label: "Below 100"
      }
      when: {
        sql: ${count_dim} >= 100 AND ${count_dim} < 200;;
        label: "100 to 200"
      }
      when: {
        sql: ${count_dim} >= 200 AND ${count_dim} < 500;;
        label: "200 to 500"
      }
      when: {
        sql: ${count_dim} >= 500 AND ${count_dim} < 1000;;
        label: "500 to 1000"
      }
      when: {
        sql: ${count_dim} >= 1000;;
        label: "1000 or Above"
      }
      else:"Unknown"
    }
  }

  measure: count_total {
    type: sum
    sql: ${count_dim} ;;
  }
}
