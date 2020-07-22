view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    tags: ["user_id"]
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    tags: ["email"]
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

#   commented out while testing https://looker.atlassian.net/browse/DD-1160
#   https://master.dev.looker.com/looks/10726
#
#   dimension: gender {
#     type: string
#     sql: ${TABLE}.gender ;;
#   }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    html:
    {% assign length = value | size %}
    {% if length > 10 %}
    <p style="font-size:10px">{{value}}</p>
     {% else %}
    <p style="font-size:6px">{{value}}</p>
    {% endif %}
    ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name ]
#       events.count,
#       orders_test.count,
#       user_data.count
#     ]
  }

  dimension: deantest {
    type:  string
    sql: ${TABLE}.deantest ;;
  }
}
