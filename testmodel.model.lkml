connection: "thelook"

include: "*.view.lkml"                       # include all views in this project

explore: fls_contracts_new {}
explore: fls_milestones {}
explore: derived_fls_contract_work_week {}

explore: fls_contracts_all_summary {
  view_label: "FLS Contracts"
  label: "FLS Contracts All Summary"
  from: fls_contracts_new
  fields: [ALL_FIELDS*]



  join: fls_milestones {
    type: left_outer
    relationship: one_to_many
    view_label: "FLS Milestones"
    sql_on: ${fls_milestones.contract_uid} = ${fls_contracts_all_summary.uid} ;;
  }

  join: fls_contract_work_weeks {
    type: left_outer
    from: derived_fls_contract_work_week
    relationship: one_to_many
    view_label: "FLS contract work weeks"
    sql_on: ${fls_contract_work_weeks.contract_uid} = ${fls_contracts_all_summary.uid} ;;
  }

}
