view: fls_contracts_new {
  sql_table_name: fls.contracts ;;

  dimension: archived {
    type: yesno
    sql: ${TABLE}."archived" ;;
  }

  dimension: assignment_rid {
    type: number
    value_format_name: id
    description: "unique identifier created when the contract is accepted by the client"
    sql: ${TABLE}."assignment_rid" ;;
  }

  dimension: client_cancel_reason {
    type: string
    description:"Reason why client cancelled the contract"
    sql: ${TABLE}."client_cancel_reason" ;;
  }

  dimension: client_uid {
    type: string
    description: "unique identifier of the client"
    sql: ${TABLE}."client_uid" ;;
  }

  dimension_group: created_on {
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
    description: "timestamp for when the contract was created by the freelancer"
    sql: ${TABLE}."created_ts" ;;
  }

  dimension: fl_org_uid {
    type: string
    description: "organization uid of the freelancer who sent the contract"
    sql: ${TABLE}."fl_org_uid" ;;
  }

  dimension: fl_person_uid {
    type: string
    description: "person uid of the freelancer who sent the contract"
    sql: ${TABLE}."fl_person_uid" ;;
  }

  dimension_group: modified_on {
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
    description: "timestamp of when the contract was last updated"
    sql: ${TABLE}."modified_ts" ;;
  }

  dimension: service_fee_pct {
    type: number
    description: "The percentage of the contract spend that Upwork collects as a service fee"
    sql: ${TABLE}."service_fee_pct" ;;
  }

  dimension: status {
    type: string
    description: "Status of the contract"
    sql: ${TABLE}."status" ;;
  }

  dimension_group: status_changed_on {
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
    description: "Timestamp for when the status last changed for the contract"
    sql: ${TABLE}."status_changed_ts" ;;
  }

  dimension_group: signed_on {
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
    description: "Timestamp for when the client signed the contract"
    sql: ${TABLE}."signed_ts" ;;
  }

  dimension: status_reason {
    type: string
    description: "Reason that the status last changed"
    sql: ${TABLE}."status_reason" ;;
  }

  dimension: total_amount {
    type: number
    value_format_name: usd
    description: "Total contract amount"
    sql: ${TABLE}."total_amount" ;;
  }

  dimension: uid {
    type: number
    primary_key: yes
    description: "Distinct ID of the contract"
    sql: ${TABLE}."uid" ;;
  }

  dimension: zendesk_ticket_id {
    type: number
    sql: ${TABLE}."zendesk_ticket_id" ;;
  }

  dimension: status_ui {
    type: string
    description: "More precise contract status to display to users"
    sql: ${TABLE}."status_ui" ;;
  }

  dimension: contract_type {
    type: string
    description: "Type of Contract (HR or FP)"
    sql: ${TABLE}."type" ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }

  measure: distinct_assignment_count {
    type: count_distinct
    description: "Distinct assignment count"
    sql: ${assignment_rid} ;;
  }

  measure: sum_contract_amount {
    type: sum
    description: "sum of total contract amount"
    value_format: "$#,##0.00"
    sql: ${total_amount} ;;
  }

  measure: average_contract_amount {
    type: average
    description: "average contract amount"
    value_format: "$#,##0.00"
    sql: ${total_amount} ;;
  }

  measure: average_hourly_rate {
    type: average
    description: "Average hourly rate"
    value_format: "$#,##0.00"
    sql: ${TABLE}."hourly_rate" ;;
  }

  measure: average_working_hours_limit {
    type: average
    description: "Average working hours limit"
    sql: ${TABLE}."weekly_hours_limit" ;;
  }

}

view: fls_milestones {
  sql_table_name: fls.milestones ;;

  dimension: amount {
    type: number
    value_format_name: usd
    description: "Amount payout requested for the milestone"
    sql: ${TABLE}."amount" ;;
  }

  dimension: paidout_amount {
    type: number
    value_format_name: usd
    label: "Paid Out Amount"
    description: "Paid out amount for the milestone"
    sql: ${TABLE}."amount_paid_out" ;;
  }

  dimension: contract_uid {
    type: number
    description: "Unique Identifier of the contract"
    sql: ${TABLE}."contract_uid" ;;
  }

  dimension_group: created_on {
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
    description: "The timestamp when the proposal was first created."
    sql: ${TABLE}."created_ts" ;;
  }

  dimension_group: modified_on {
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
    description: "The timestamp when the proposal was last modified."
    sql: ${TABLE}."modified_ts" ;;
  }

  dimension_group: funded_on {
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
    description: "The timestamp when the proposal was funded."
    sql: ${TABLE}."funded_ts" ;;
  }

  dimension: order_num {
    type: number
    sql: ${TABLE}."order_num" ;;
  }

  dimension: status {
    type: string
    description: "The milestone status as per the last status change operation."
    sql: ${TABLE}."status" ;;
  }

  dimension_group: status_changed_on {
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
    description: "The timestamp when the milestone status was last changed"
    sql: ${TABLE}."status_changed_ts" ;;
  }

  dimension: uid {
    type: number
    primary_key: yes
    description: "Unique identifier of the milestone"
    sql: ${TABLE}."uid" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: distinct_contract_count {
    type : count_distinct
    description: "Distinct contract UID count"
    sql: ${TABLE}."contract_uid";;

  }

  measure: amount_sum {
    type: sum
    description: "Total contract amount ($)"
    value_format: "$#,##0.00"
    sql: ${TABLE}."amount" ;;
  }

  measure: paidout_amount_sum {
    type: sum
    description: "Contracts total paidout amount ($)"
    value_format: "$#,##0.00"
    sql: ${TABLE}."amount_paid_out" ;;
  }

  measure: amount_avg {
    type: average
    description: "Average contract amount ($)"
    value_format: "$#,##0.00"
    sql: ${TABLE}."amount" ;;
  }

  measure: paidout_amount_avg {
    type: average
    label: "Average Paid Out Amount"
    description: "Contracts average paid out amount ($)"
    value_format: "$#,##0.00"
    sql: ${TABLE}."amount_paid_out" ;;
  }

  measure: created_to_funded_7d_count {
    label: "Created to funded 7d count"
    description: "Conversion from created to funded 7d contract count"
    type: count_distinct
    sql: case when ${funded_on_date} <= ${created_on_date} + INTERVAL '7 DAYS' then ${contract_uid} end ;;
  }

  measure: created_to_completed_7d_count {
    label: "Created to completed 7d count"
    description: "Conversion from created to completed 7d contract count"
    type: count_distinct
    sql: case when ${status} = 'CLOSED' AND ${funded_on_date} is not null and ${status_changed_on_date} <= ${created_on_date} + INTERVAL '7 DAYS' then ${contract_uid} end ;;
  }
}

view: derived_fls_contract_work_week {

  derived_table: {
    sql: select cw.*
      , e.expenses_amount
      , e.expenses_amount_paid_out
      from fls.contract_work_weeks as cw
      left join (select contract_uid
      , week_date_iso
      , sum(amount) as expenses_amount
      , sum(case when status = 'CLOSED' then amount_paid_out end) as expenses_amount_paid_out
      from fls.expenses e
      group by 1,2) as e
      on e.contract_uid = cw.contract_uid
      and e.week_date_iso = cw.week_date_iso;;
  }

  dimension: contract_uid {
    type: number
    description: "Contract unique identification"
    sql: ${TABLE}."contract_uid" ;;
  }



  dimension_group: charged_week {
    type: time
    timeframes: [
      raw,
      week,
      month,
      quarter,
      year
    ]
    description: "Timestamp when freelancer working hours logged"
    sql: TO_DATE(SUBSTRING(${TABLE}."week_date_iso",1,4) || '' || SUBSTRING(${TABLE}."week_date_iso",6,2), 'IYYYIW') ;;
  }


  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}."contract_uid", ' ', ${TABLE}."week_date_iso") ;;
  }

  dimension_group: client_charged_week {
    type: time
    timeframes: [
      raw,
      week,
      month,
      quarter,
      year
    ]
    description: "Timestamp when client getting charged"
    sql: TO_DATE(SUBSTRING(${TABLE}."week_date_iso",1,4) || '' || SUBSTRING(${TABLE}."week_date_iso",6,2), 'IYYYIW') + Interval '7 days' ;;
  }

  dimension_group: paidout_week {
    type: time
    timeframes: [
      raw,
      week,
      month,
      quarter,
      year
    ]
    description: "Timestamp when freelancer getting paid"
    sql: TO_DATE(SUBSTRING(${TABLE}."week_date_iso",1,4) || '' || SUBSTRING(${TABLE}."week_date_iso",6,2), 'IYYYIW') + Interval '11 days' ;;
  }

  dimension: status {
    type: string
    description: "Status of the contract in respected week"
    sql: ${TABLE}."status" ;;
  }

  measure: contracts_count {
    type: count_distinct
    description: "Distinct contract count"
    sql:${TABLE}."contract_uid" ;;
  }


  measure: paidout_amount_sum {
    type: sum
    description: "Paid out amount sum"
    value_format: "$#,##0.00"
    sql: (coalesce(${TABLE}."amount_paid_out",0) + coalesce(${TABLE}.expenses_amount_paid_out,0)) ;;
  }

  measure: paidout_amount_avg {
    type: number
    description: "Paid out amount average"
    value_format: "$#,##0.00"
    sql: sum(coalesce(${TABLE}."amount_paid_out",0) + coalesce(${TABLE}.expenses_amount_paid_out,0)) / count(distinct case when ${TABLE}."amount_paid_out" > 0 or ${TABLE}.expenses_amount_paid_out > 0 then ${contract_uid} end) ;;
  }
}
