view: user_facts {
  derived_table: {
    explore_source: order_items {
      column: id { field: users.id }
      column: count { field: orders.count }
      column: distinct_items { field: orders.distinct_items }
      column: most_recent { field: orders.most_recent }
      column: email { field: users.email }
      column: city { field: users.city }
    }
  }

  dimension: id {
    type: number
  }

  dimension: count {
    type: number
  }

  dimension: distinct_items {
    type: number
  }

  dimension: most_recent {
    type: number
  }

  dimension: email {}

  dimension: city {}

  dimension: deantest {
    type:  yesno
  }

}
