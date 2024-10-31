# tasks sql 1

SELECT
    r.user_id,
    SUM(r.reward) AS total_reward_2022
FROM
    reports r
WHERE
    r.user_id IN (
        SELECT
            user_id
        FROM
            reports
        WHERE
            EXTRACT(YEAR FROM created_at) = 2021
        GROUP BY
            user_id
        HAVING
            MIN(created_at) = MIN(CASE WHEN EXTRACT(YEAR FROM created_at) = 2021 THEN created_at END)
    )
    AND EXTRACT(YEAR FROM r.created_at) = 2022
GROUP BY
    r.user_id;

# tasks sql 2

SELECT
    p.title AS pos_title,
    STRING_AGG(r.barcode, ', ') AS barcodes,
    STRING_AGG(r.price::text, ', ') AS prices
FROM
    pos p
JOIN
    reports r ON p.id = r.pos_id
GROUP BY
    p.title;

