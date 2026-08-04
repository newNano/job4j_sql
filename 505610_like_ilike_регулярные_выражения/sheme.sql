--вывести всех пользователей, у которых email содержит mail. В результатах отражаем колонки: id, name, email;
SELECT id, name, email
FROM idea_db."505601".users
WHERE email ILIKE '%mail%';

--вывести все товары, название которых содержит air. В результатах отражаем колонки: id, name, price;
SELECT id, name, price
FROM idea_db."505601".products
WHERE name ILIKE '%air%';

--вывести все товары, название которых начинается с i. В результатах отражаем колонки: id, name, price;
SELECT id, name, price
FROM idea_db."505601".products
WHERE name ILIKE 'i%';

--вывести все товары, название которых заканчивается на pro. В результатах отражаем колонки: id, name, price;
SELECT id, name, price
FROM idea_db."505601".products
WHERE name ILIKE '%pro';

--вывести всех пользователей, у которых имя начинается на A или I, регистр не важен. В результатах отражаем колонки: id, name, email;
SELECT id, name, email
FROM idea_db."505601".users
WHERE name ~* '(^A|^I)';

--вывести все вакансии, где в названии или описании встречается java, go или postgres. В результатах отражаем колонки:  id, title, company, description;
SELECT id, title, company, description
FROM idea_db."505601".vacancies
WHERE title ~* '(java|go|postgres)' OR description ~* '(java|go|postgres)';


--через regex найти товары, название которых начинается с iPhone, а затем содержит номер модели. В результатах отражаем колонки: id, name, price.
SELECT id, name, price
FROM idea_db."505601".products
WHERE name ~* '^iphone [0-9]+'
