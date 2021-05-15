-- ���������� �������, ������� � �� ����� 6, � �������������� JOIN.
-- �� � ����� 6 (�. 3 � 4)

-- 3. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
/*�.�. ���������� ��������� ����� � ������� likes � ��� �� profiles. 
���������� � ����� ������� ���������� ������� � ���� ���� ��������

desc likes;
select * from likes limit 10;
select * from profiles limit 10; 

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender-- ����. ������ � ����. ��������.
/*	
 ���� �� user_id ������� ���������� user_id ����. likes (user_id � likes - ��� ��� ������������, ������� �������� ����) 
 � ��� ������� �� ���� ������������� ���� ���

	FROM likes; -- ������ �������� �������� ������� ������, ��� ��� ����� ������� �����

-- ���������� � ���������
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total-- ������������ ���������� ����� ��� ������� ����
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1; -- �����������. ��������� ������������� �������� 
*/
    
-- � �������������� JOIN.
    
desc likes;
select * from likes limit 10;
select * from profiles limit 10; 

-- ������� ������� ������������  
SELECT profiles.gender, COUNT(likes.id) AS total_likes
  FROM likes inner JOIN profiles
  ON likes.user_id = profiles.user_id
  GROUP by profiles.gender
  ORDER BY total_likes;
 
/*
-- 4. ������� ��� ������� ������������ ���������� ��������� ���������, ������,
-- ����������� ����������� � ������������ ������.
 
-- � �������-�� ��������� ��������
SELECT 
CONCAT(first_name, ' ', last_name) AS user,
(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS total_messages,
(SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS total_posts,  
(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) AS total_media, 
(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) AS total_likes
FROM users;-- ������ �������� �������� ������� users, ��� ��� ���������� "������� ��� ������� ������������"
*/

-- � �������������� JOIN.
SELECT CONCAT(first_name, ' ', last_name) AS user, messages.from_user_id AS total_messages, 
posts.user_id AS total_posts, media.user_id AS total_media, likes.user_id  AS total_likes 
FROM ((((users inner JOIN messages on users.id = messages.from_user_id)
inner JOIN posts on users.id = posts.user_id) 
inner JOIN media on users.id = media.user_id) 
inner JOIN likes on users.id = likes.id)
order by user;



	 