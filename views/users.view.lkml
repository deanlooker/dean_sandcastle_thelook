view: users {
  sql_table_name: demo_db.users ;;
  # drill_fields: [id]

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

  measure: age_percentile {
    type: percentile
    percentile: 50
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "dash"
      url: "{% if _user_attributes['state'] == 'New York' %} /explore/dean_test/users?fields=users.count&limit=500 {% else %} /dashboards/3 {% endif %}"
    }
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

  dimension: last_id {
    type: number
    sql: (SELECT ${TABLE}.id
      FROM ${TABLE}
      ORDER BY ${TABLE}.created_at DESC
      LIMIT 1)
      ;;
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

  dimension: full_name {
    label: "{{ _view._name }} Name"
    type:  string
    sql: concat(${first_name},${last_name}) ;;
    html: <div style="text-align:center">{{rendered_value}}</div> ;;
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

  dimension: state_case {
    case: {
      when: {
        sql: users.state in ('Maine', 'Vermont', 'New Hampshire', 'Massachusetts', 'Rhode Island', 'Connecticut');;
        label: "New England"
      }
      when: {
        sql: users.state in ('California', 'Oregon', 'Washington', 'Hawaii', 'Alaska');;
        label: "Pacific"
      }
      when: {
        sql: users.state in ('New York','New Jersey','Pennsylvania', 'Delaware', 'Maryland');;
        label: "Mid-Atlantic"
      }
      when: {
        sql: users.state in ('New York','New Jersey','Pennsylvania');;
        label: "Mid-Atlantic"
      }
      when: {
        sql: users.state in ('Indiana','Illinois','Ohio','Kansas','Missouri','Michigan','Wisconsin','Iowa','Nebraska','South Dakota','North Dakota','Nebraska');;
        label: "Midwest"
      }
      when: {
        sql: users.state in ('Colorado','Nevada','Utah','Montana','New Mexico','Arizona','Idaho','Wyoming');;
        label: "Mountain West"
      }
      else: "South"
    }
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    # drill_fields: [detail*]
    link: {
      # label: "dash"
      url: "/explore/dean_test/users?fields=users.count&limit=500"
    }
    # html: {% if dean_orders_2.count._in_query %}
    # {% else %}
    # {{linked_value}}
    # {% endif %};;
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
