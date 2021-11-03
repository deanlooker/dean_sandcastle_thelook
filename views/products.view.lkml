view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    action: {
      label: "Cool Name?"
      url: "https://webhook.site/d9fdaf45-4850-4af0-a042-664bbe8259eb"
      param: {
        name: "name"
        value: "{{ value }}"
      }
      form_param: {
        name: "annotation"
        type: select
        label: "Cool name?"
        default: "No"
        description: "Do you think that this name is a cool name?"
        option: {
          name: "No"
        }
        option: {
          name: "Yes"
        }
      }
    }
  }

  dimension: category {
    type: string
    group_label: "{% if _explore._name == 'products' %}1. Category
    {% else %}X Category
    {% endif %}"
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
