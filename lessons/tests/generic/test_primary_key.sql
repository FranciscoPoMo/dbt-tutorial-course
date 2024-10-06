{#
    This test is a "not_null" and "unique"
    rolled into one single test.

    It fails if a column is NULL or occurs more that once.
#}

{% test primary_key(model, column_name) %}

WITH validation AS (
    SELECT
        {{ column_name }} AS pk
        , COUNT(1) AS ocurrences
    FROM {{ model }}
    GROUP BY 1
)

SELECT
    v.*
FROM validation AS v
WHERE v.pk IS NULL
    OR v.ocurrences > 1

{% endtest %}
