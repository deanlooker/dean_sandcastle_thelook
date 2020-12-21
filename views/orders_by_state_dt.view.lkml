# If necessary, uncomment the line below to include explore_source.
# include: "dean_test.model.lkml"

view: orders_by_state_dt {
  derived_table: {
    explore_source: order_items {
      column: state { field: users.state }
      column: created_month { field: orders.created_month }
      column: count { field: orders.count }
      filters: {
        field: orders.created_date
        value: "2018/01/01 to 2018/12/31"
      }
    }
  }
  dimension: state {}
  dimension: created_month {
    type: date_month
  }
  dimension: count {
    type: number
  }
}
