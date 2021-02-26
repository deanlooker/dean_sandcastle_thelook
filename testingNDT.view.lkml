view: testingndt {
  derived_table: {
    explore_source: orders {
      column: count {}
      column: user_id {}
      column: created_date { field: users.created_date }
      derived_column: daydiff {
        sql:  if(${orders.user_id}!=offset(${orders.user_id},-1),0,diff_days(${users.created_date},offset(${users.created_date},-1))*-1) ;;
      }
      filters: {
        field: users.created_date
        value: "12 months"
      }
    }
  }
  dimension: count {
    type: number
  }
  dimension: user_id {
    type: number
  }
  dimension: created_date {
    type: date
  }
}
