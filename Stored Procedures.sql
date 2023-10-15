
SELECT * from  Products
SELECT * from Customers
SELECT * from OrderSales

SELECT * from  ProductInventory 


-- Create a stored procedure to update the ProductInventory table
ALTER PROCEDURE Update_Product_Inventory
    @ProductID INT,
    @QuantitySold INT
AS
BEGIN
    -- Update the ProductInventory table
    UPDATE ProductInventory
    SET
        QuantitySold = QuantitySold + @QuantitySold,
        QuantityRemaining = QuantityRemaining - @QuantitySold
    WHERE ProductID = @ProductID;
END;

EXEC Update_Product_Inventory @ProductID = 1, @QuantitySold=5;



-- Create an AFTER INSERT trigger to update ProductInventory when a new order is placed
CREATE TRIGGER UpdateProductInventoryOnOrderInsert
ON OrderSales
AFTER INSERT
AS
BEGIN
    -- Update ProductInventory based on the new order
    UPDATE pi
    SET
        pi.QuantitySold = pi.QuantitySold + i.Quantity,
        pi.QuantityRemaining = pi.QuantityRemaining - i.Quantity
    FROM ProductInventory pi
    JOIN inserted i ON pi.ProductID = i.ProductID;
END;

EXEC UpdateProductInventoryOnOrderInsert




