-- Переписать запросы, заданые к ДЗ урока 6, с использованием JOIN.
-- ДЗ к уроку 6 (П. 3 И 4)

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
/*Т.е. Необходимо посчитать ЛАЙКИ в таблице likes и ПОЛ из profiles. 
Необходимо в ОБЩЕМ запросе объединить запросы к этим двум таблицам

desc likes;
select * from likes limit 10;
select * from profiles limit 10; 

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender-- Влож. запрос к табл. ПРОФИЛЕЙ.
/*	
 Ищем по user_id ПРОФИЛЯ совпадения user_id табл. likes (user_id в likes - Это тот пользователь, который поставил ЛАЙК) 
 И для каждого из этих пользователей ищем пол

	FROM likes; -- Делаем основным запросом таблицу ЛАЙКОВ, так как будем считать ЛАЙКИ

-- Группируем и сортируем
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total-- Подсчитываем количество строк для каждого пола
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1; -- Ограничение. Получение единственного значения 
*/
    
-- С использованием JOIN.
    
desc likes;
select * from likes limit 10;
select * from profiles limit 10; 

-- Подсчёт заказов пользователя  
SELECT profiles.gender, COUNT(likes.id) AS total_likes
  FROM likes inner JOIN profiles
  ON likes.user_id = profiles.user_id
  GROUP by profiles.gender
  ORDER BY total_likes;
 
/*
-- 4. Вывести для каждого пользователя количество созданных сообщений, постов,
-- загруженных медиафайлов и поставленных лайков.
 
-- С использ-ем ВЛОЖЕННЫХ запросов
SELECT 
CONCAT(first_name, ' ', last_name) AS user,
(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS total_messages,
(SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS total_posts,  
(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) AS total_media, 
(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) AS total_likes
FROM users;-- Делаем основным запросом таблицу users, так как необходимо "Вывести для каждого пользователя"
*/

-- С использованием JOIN.
SELECT CONCAT(first_name, ' ', last_name) AS user, messages.from_user_id AS total_messages, 
posts.user_id AS total_posts, media.user_id AS total_media, likes.user_id  AS total_likes 
FROM ((((users inner JOIN messages on users.id = messages.from_user_id)
inner JOIN posts on users.id = posts.user_id) 
inner JOIN media on users.id = media.user_id) 
inner JOIN likes on users.id = likes.id)
order by user;



	 