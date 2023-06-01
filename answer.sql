-- TYPE YOUR SQL QUERY BELOW
-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change
SELECT AVG(total_per_day_users_before) AS average_users_before,
    AVG(total_per_day_users_after) AS average_users_after
FROM (
        SELECT date(login_timestamp, 'unixepoch') AS login_date,
            COUNT(DISTINCT user_id) AS total_per_day_users_before
        FROM login_history
        WHERE login_timestamp < strftime('%s', '2018-06-02')
        GROUP BY login_date
    ) subquery1
    FULL OUTER JOIN (
        SELECT date(login_timestamp, 'unixepoch') AS login_date,
            COUNT(DISTINCT user_id) AS total_per_day_users_after
        FROM login_history
        WHERE login_timestamp >= strftime('%s', '2018-06-02')
        GROUP BY login_date
    ) subquery2 ON subquery1.login_date = subquery2.login_date;
-- PART 2: Create a SQL query that indicates the number of status changes by card 
SELECT card.name,
    COUNT(*)
FROM card
    INNER JOIN card_change_history ON card.id = card_change_history.cardID
GROUP BY card.name;