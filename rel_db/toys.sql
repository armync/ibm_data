CREATE TABLE Toys (
    ID INT NOT NULL,
    Variety VARCHAR(50),
    Quantity INT
);

INSERT INTO Toys(ID,Variety,Quantity)
VALUES
(1,'Chew Toy','20'),
(2,'Balls','50'),
(3,'Bowls','30'),
(4,'Foldable bed','40');

ALTER TABLE Toys
MODIFY Variety VARCHAR(30);

TRUNCATE TABLE Toys;

DROP TABLE Toys;