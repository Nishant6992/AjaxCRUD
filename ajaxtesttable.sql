CREATE TABLE Contacts (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,  -- Assuming you want an auto-incrementing primary key
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NULL,
    Address NVARCHAR(255) NULL,
    CreatedDate DATETIME NOT NULL
);
ALTER table Contacts
add  IsDeleted bit default 0
CREATE PROCEDURE InsertContacts
    @Name NVARCHAR(100),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @Address NVARCHAR(255),
    @CreatedDate DATETIME
AS
BEGIN
    INSERT INTO Contacts (Name, Email, Phone, Address, CreatedDate)
    VALUES (@Name, @Email, @Phone, @Address, @CreatedDate);
END
CREATE PROCEDURE searchall
    @searchkeyword NVARCHAR(255)
AS
BEGIN
    -- Use a parameterized query to prevent SQL injection
    SELECT ContactID, Name, Email, Phone, Address, CreatedDate
    FROM Contacts
    WHERE
        (Name LIKE '%' + @searchkeyword + '%' OR
        Email LIKE '%' + @searchkeyword + '%' OR
        Phone LIKE '%' + @searchkeyword + '%' OR
        Address LIKE '%' + @searchkeyword + '%')
    ORDER BY CreatedDate DESC; -- Optional: Order results by CreatedDate or any other column
END
CREATE PROCEDURE UpdateContact
    @ContactID INT,
    @Name NVARCHAR(255),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(50),
    @Address NVARCHAR(255),
    @CreatedDate DATE
AS
BEGIN
    -- Update the contact details in the Contacts table
    UPDATE Contacts
    SET
        Name = @Name,
        Email = @Email,
        Phone = @Phone,
        Address = @Address,
        CreatedDate = @CreatedDate
    WHERE
        ContactID = @ContactID;
END
