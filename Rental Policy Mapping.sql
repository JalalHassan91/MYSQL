SELECT
    accounts.id,
    accounts.name,
    accounts_rental_policies_relations.rental_policy_id,
    rental_policies.type_vid as 'rental policy type vocabulary id',
    rental_policies.name as 'rental policy name',
    rental_policies_relations.policy_id,
    policies.name as 'policy name',
    policies.priority,
    policies.base_date_vid as 'base date vocabulary id',
    policies.operator,
    policies.offset_days,
    policies.fee_type_vid as 'fee type vocabulary id',
    vocabularies.name as 'fee type name',
       vocabularies.label as 'fee type label',
    policies.value,
    policies.value_type
FROM
    accounts
    INNER JOIN accounts_rental_policies_relations
     ON accounts.id = accounts_rental_policies_relations.account_id
    INNER JOIN rental_policies_relations
     ON accounts_rental_policies_relations.rental_policy_id = rental_policies_relations.rental_policy_id
    LEFT OUTER JOIN rental_policies
     ON accounts_rental_policies_relations.rental_policy_id = rental_policies.id
    LEFT OUTER JOIN policies
     ON rental_policies_relations.policy_id = policies.id
    LEFT OUTER JOIN vocabularies
     ON policies.fee_type_vid = vocabularies.id
WHERE
    accounts_rental_policies_relations.channel_vid = '0'