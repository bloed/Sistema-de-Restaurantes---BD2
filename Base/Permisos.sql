--GRANT EXECUTE ON msdb.dbo.sp_send_dbmail to rolTodos--da permiso de mandar correos
use [RESTAURANTES]
 GRANT ALTER ANY USER TO rolAdministrador--permiso de manejar users
 GRANT ALTER ANY ROLE TO rolAdministrador--permiso de manejar roles
 USE [MASTER]
 /*GRANT ALTER ANY LOGIN TO admin1 -- para dar permiso de crear logins a un login. Esto se hace en el MASTER*/
 ------correos
 /*USE msdb
GO
grant execute on msdb.dbo.sp_send_dbmail to public--esta charral pero fue como encontre*/