-- 1. Составить запрос, который выводит:
-- кол-во действий за определённый месяц (скажем февраль 2020);
-- кол-во сотрудников, которые выполняли хоть какие-нибудь действия за указанный период;
SELECT COUNT(*) num_actions, COUNT(DISTINCT employer_id) num_employers
  FROM actions
 WHERE DATE_TRUNC('month', dt) = '2020-02-01';

-- 2. Составить запрос, который выводит логины сотрудников, которые не выполняли никаких действий в феврале 2020.
SELECT login
  FROM employees
 WHERE id NOT IN
       (SELECT DISTINCT employer_id
          FROM actions
         WHERE DATE_TRUNC('month', dt) = '2020-02-01');


-- 3. Составить запрос, который выводит 5 сотрудников с наибольшим количеством действий за февраль 2020, а также кол-во
-- их действий, отсортированных в порядке убывания.
  WITH stats AS (SELECT employer_id, COUNT(action) num_action
                   FROM actions
                  WHERE DATE_TRUNC('month', dt) = '2020-02-01'
                  GROUP BY employer_id
                  ORDER BY COUNT(action) DESC
                  LIMIT 5)
SELECT e.id, e.login, s.num_action
  FROM stats s
           JOIN employees e ON s.employer_id = e.id
 ORDER BY s.num_action DESC;