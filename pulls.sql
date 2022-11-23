--lab3

-- crud, order by, limit, in, like
SELECT * FROM Users
ORDER BY Name_;

SELECT * FROM Users
ORDER BY Name_
LIMIT 2 OFFSET 1;

SELECT * FROM Users
WHERE Name_ IN ('theboatman', 'admin');

SELECT * FROM Users
WHERE Name_ LIKE ('%n');

UPDATE Users
SET Name_ = 'BANNED'
where IsBanned_ = 'T';   

DELETE FROM Users
WHERE IsBanned_ = 'T';

SELECT COUNT(*) FROM Users;

--lab4

--several conditions
SELECT Name_ FROM Users
WHERE IsBanned_ = 'T' AND Name_ LIKE ('K%');


--embedded
SELECT Name_ FROM Users
WHERE RoleId IN (
    SELECT RoleId FROM Roles
    WHERE RoleName_ = 'default'
    );

--joins

--Inner
SELECT Users.Name_, AuthUser.PasswordHash_ FROM AuthUser
JOIN Users ON AuthUser.AuthUserId = Users.UserId;

--Outer
SELECT Users.Name_, AuthUser.PasswordHash_ FROM AuthUser
RIGHT JOIN Users ON AuthUser.AuthUserId = Users.UserId;

--Cross
SELECT Users.Name_, Roles.RoleName_ FROM Users
CROSS JOIN Roles;

--groups

--GROUP BY +
SELECT RoleName_, COUNT(*) FROM(
    SELECT Users.Name_, Roles.RoleName_ FROM Users
    JOIN Roles ON Users.RoleId = Roles.RoleId) AS T
GROUP BY RoleName_;

--HAVING
SELECT Name_, COUNT(*) AS LogsCount FROM
(SELECT Name_ FROM Users
JOIN Logs ON Users.UserId = Logs.UserId) AS T
GROUP BY T.Name_
HAVING COUNT(*) > 1;

--INTERSECT
SELECT PasswordHash_ FROM AuthUser
INTERSECT
SELECT Name_ FROM Users;

--CASE
SELECT Name_, CASE
        WHEN IsBanned_ = 'T' THEN 'User has ban'
        ELSE 'User hasnt ban'
    END
FROM Users;

--EXPLAIN
