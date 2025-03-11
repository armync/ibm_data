SELECT S.NAME_OF_SCHOOL, S.COMMUNITY_AREA_NAME, S.AVERAGE_STUDENT_ATTENDANCE
FROM chicago_public_schools S
INNER JOIN chicago_socioeconomic_data E
ON S.COMMUNITY_AREA_NUMBER = E.COMMUNITY_AREA_NUMBER
WHERE E.HARDSHIP_INDEX = 98;

SELECT C.CASE_NUMBER, C.PRIMARY_TYPE, E.COMMUNITY_AREA_NAME
FROM chicago_crime C
INNER JOIN chicago_socioeconomic_data E
ON C.COMMUNITY_AREA_NUMBER = E.COMMUNITY_AREA_NUMBER
WHERE C.LOCATION_DESCRIPTION LIKE "%SCHOOL%";

CREATE VIEW school_chicago_view(
    School_Name,
    Safety_Rating,
    Family_Rating,
    Environment_Rating,
    Instruction_Rating,
    Leaders_Rating,
    Teachers_Rating) AS
SELECT
NAME_OF_SCHOOL,
Safety_Icon,
Family_Involvement_Icon,
Environment_Icon,
Instruction_Icon,
Leaders_Icon,
Teachers_Icon
FROM chicago_public_schools;

SELECT * FROM school_chicago_view;

SELECT School_Name, Leaders_Rating FROM school_chicago_view;

--

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //

CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
BEGIN
    UPDATE chicago_public_schools
    SET Leaders_Score = in_Leader_Score
    WHERE School_ID = in_School_ID;

    IF in_Leader_Score >= 80 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Very strong'
    	WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 60 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'strong'
    	WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 40 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Average'
        WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 20 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Weak'
    	WHERE School_ID = in_School_ID;

    ELSE
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Very weak'
    	WHERE School_ID = in_School_ID;

    END IF;
end //

DELIMITER ;

--

CALL UPDATE_LEADERS_SCORE(610213, 75);

--

DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //

CREATE PROCEDURE UPDATE_LEADERS_SCORE(IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    UPDATE chicago_public_schools
    SET Leaders_Score = in_Leader_Score
    WHERE School_ID = in_School_ID;

    IF in_Leader_Score >= 80 AND in_Leader_Score <= 99 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Very strong'
    	WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 60 AND in_Leader_Score <= 79  THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'strong'
    	WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 40 AND in_Leader_Score <= 59 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Average'
        WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 20 AND in_Leader_Score <= 39 THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Weak'
    	WHERE School_ID = in_School_ID;

    ELSEIF in_Leader_Score >= 0  AND in_Leader_Score <= 19  THEN
    	UPDATE chicago_public_schools
    	SET Leaders_Icon = 'Very weak'
    	WHERE School_ID = in_School_ID;

    ELSE
    	ROLLBACK;
        RESIGNAL;

    END IF;

    COMMIT;
end //

DELIMITER ;

--

CALL UPDATE_LEADERS_SCORE(610320, 37);

CALL UPDATE_LEADERS_SCORE(610320, -1);

CALL UPDATE_LEADERS_SCORE(610320, 101);
