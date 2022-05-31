view: nested_and_repeated {
  sql_table_name: `looker_test.nested_and_repeated`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: doubly_nested_and_repeated {
    hidden: yes
    sql: ${TABLE}.doubly_nested_and_repeated ;;
  }

  dimension: nested_field__this_inner_float {
    type: number
    sql: ${TABLE}.nested_field.this_inner_float ;;
    group_label: "Nested Field"
    group_item_label: "This Inner Float"
  }

  dimension: nested_field__this_inner_string {
    type: string
    sql: ${TABLE}.nested_field.this_inner_string ;;
    group_label: "Nested Field"
    group_item_label: "This Inner String"
  }

  dimension: repeated_field {
    hidden: yes
    sql: ${TABLE}.repeated_field ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: nested_and_repeated__repeated_field {
  dimension: nested_and_repeated__repeated_field {
    type: string
    sql: nested_and_repeated__repeated_field ;;
  }
}

view: nested_and_repeated__doubly_nested_and_repeated {
  dimension: inner_repeated {
    hidden: yes
    sql: inner_repeated ;;
  }

  dimension: nested_and_repeated__doubly_nested_and_repeated {
    type: string
    hidden: yes
    sql: nested_and_repeated__doubly_nested_and_repeated ;;
  }

  dimension: other_field {
    type: number
    sql: other_field ;;
  }
}

view: nested_and_repeated__doubly_nested_and_repeated__inner_repeated {
  dimension: nested_and_repeated__doubly_nested_and_repeated__inner_repeated {
    type: string
    sql: nested_and_repeated__doubly_nested_and_repeated__inner_repeated ;;
  }
}
