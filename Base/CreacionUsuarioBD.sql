		--USUARIO DE CONSULTA DE BD
		DECLARE @user VARCHAR(25) = 'usuario'
		DECLARE @password VARCHAR(25) = 'usuario'
		DECLARE @command NVARCHAR(500)
		DECLARE @command2 NVARCHAR(500)
		DECLARE @command3 NVARCHAR(500)
		SET @command = N'create login ' + @user + ' with password=''' + @password + ''', default_database=RESTAURANTES';

		EXECUTE sp_executesql @command;
		
		SET @command2 =  'CREATE USER ' + quotename(@user) + ' FOR LOGIN ' + quotename(@user)
		EXECUTE sp_executesql @command2;

		exec sp_addrolemember rolCliente, @user--le damos permiso de cliente
		exec sp_addrolemember 'db_datareader', @user --le damos permiso de ver (select's)


		--USUARIO ADMINISTRADOR DE BD
		SET @password = 'admin'
		DECLARE @username VARCHAR(25) = 'admin'
		 --necesita tener un login, user y asociarlos al rol
		SET @command = N'create login ' + @username + ' with password=''' +@Password + ''', default_database=RESTAURANTES';

		EXECUTE sp_executesql @command;
		
		SET @command2 =  'CREATE USER ' + quotename(@username) + ' FOR LOGIN ' + quotename(@username)
		EXECUTE sp_executesql @command2;

		exec sp_addrolemember rolAdministrador, @username--le damos permiso de TODO dentro de la base de datos.
		exec sp_addrolemember 'db_owner', @username--le damos permiso de TODO dentro de la base de datos.