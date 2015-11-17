CREATE FUNCTION [dbo].[verifyPlatillo]
(@platillo VARCHAR(25))
RETURNS INT
	--verifica que de un platillo tenga todos sus ingredientes
	
AS
BEGIN
	
	

    DECLARE @ingredienteActual VARCHAR(25) = ''
	DECLARE cursorP CURSOR FOR Select nombreIngrediente FROM IngredientesPlatillos WHERE nombrePlatillo = @platillo

	OPEN cursorP

	FETCH NEXT FROM cursorP INTO @ingredienteActual

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF EXISTS(SELECT 'True' 
							FROM Ingredientes i, IngredientesCategorias ic
								WHERE i.nombre = ic.nombreIngrediente	
								AND ic.cantidad >=1)
								BEGIN
									FETCH NEXT FROM cursorP INTO @ingredienteActual
								END
			ELSE
				BEGIN
					RETURN 0-- no es valido
				END
		END

	CLOSE cursorP
	DEALLOCATE cursorP
	RETURN 1--es valido
END