use [RESTAURANTES]
exec sp_replicationdboption @dbname = N'RESTAURANTES', @optname = N'publish', @value = N'true'
GO
-- Adding the transactional publication
use [RESTAURANTES]
exec sp_addpublication @publication = N'Transaccional', @description = N'Transactional publication of database ''RESTAURANTES'' from Publisher ''LDA''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot @publication = N'Transaccional', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = null, @job_password = null, @publisher_security_mode = 1


use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Administradores', @source_owner = N'dbo', @source_object = N'Administradores', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Administradores', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAdministradores', @del_cmd = N'CALL sp_MSdel_dboAdministradores', @upd_cmd = N'SCALL sp_MSupd_dboAdministradores'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Avenidas', @source_owner = N'dbo', @source_object = N'Avenidas', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Avenidas', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboAvenidas', @del_cmd = N'CALL sp_MSdel_dboAvenidas', @upd_cmd = N'SCALL sp_MSupd_dboAvenidas'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Barrios', @source_owner = N'dbo', @source_object = N'Barrios', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Barrios', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboBarrios', @del_cmd = N'CALL sp_MSdel_dboBarrios', @upd_cmd = N'SCALL sp_MSupd_dboBarrios'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'BitacoraAdministradores', @source_owner = N'dbo', @source_object = N'BitacoraAdministradores', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'BitacoraAdministradores', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboBitacoraAdministradores', @del_cmd = N'CALL sp_MSdel_dboBitacoraAdministradores', @upd_cmd = N'SCALL sp_MSupd_dboBitacoraAdministradores'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'CallesAvenidas', @source_owner = N'dbo', @source_object = N'CallesAvenidas', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'CallesAvenidas', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCallesAvenidas', @del_cmd = N'CALL sp_MSdel_dboCallesAvenidas', @upd_cmd = N'SCALL sp_MSupd_dboCallesAvenidas'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'CategoriasIngredientes', @source_owner = N'dbo', @source_object = N'CategoriasIngredientes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'CategoriasIngredientes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCategoriasIngredientes', @del_cmd = N'CALL sp_MSdel_dboCategoriasIngredientes', @upd_cmd = N'SCALL sp_MSupd_dboCategoriasIngredientes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'CategoriasRestaurantes', @source_owner = N'dbo', @source_object = N'CategoriasRestaurantes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'CategoriasRestaurantes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCategoriasRestaurantes', @del_cmd = N'CALL sp_MSdel_dboCategoriasRestaurantes', @upd_cmd = N'SCALL sp_MSupd_dboCategoriasRestaurantes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Clientes', @source_owner = N'dbo', @source_object = N'Clientes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Clientes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboClientes', @del_cmd = N'CALL sp_MSdel_dboClientes', @upd_cmd = N'SCALL sp_MSupd_dboClientes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Compras', @source_owner = N'dbo', @source_object = N'Compras', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Compras', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCompras', @del_cmd = N'CALL sp_MSdel_dboCompras', @upd_cmd = N'SCALL sp_MSupd_dboCompras'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Cuadras', @source_owner = N'dbo', @source_object = N'Cuadras', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Cuadras', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboCuadras', @del_cmd = N'CALL sp_MSdel_dboCuadras', @upd_cmd = N'SCALL sp_MSupd_dboCuadras'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'DescuentoClientes', @source_owner = N'dbo', @source_object = N'DescuentoClientes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'DescuentoClientes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboDescuentoClientes', @del_cmd = N'CALL sp_MSdel_dboDescuentoClientes', @upd_cmd = N'SCALL sp_MSupd_dboDescuentoClientes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Ingredientes', @source_owner = N'dbo', @source_object = N'Ingredientes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Ingredientes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboIngredientes', @del_cmd = N'CALL sp_MSdel_dboIngredientes', @upd_cmd = N'SCALL sp_MSupd_dboIngredientes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'IngredientesCategorias', @source_owner = N'dbo', @source_object = N'IngredientesCategorias', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'IngredientesCategorias', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboIngredientesCategorias', @del_cmd = N'CALL sp_MSdel_dboIngredientesCategorias', @upd_cmd = N'SCALL sp_MSupd_dboIngredientesCategorias'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'IngredientesPlatillos', @source_owner = N'dbo', @source_object = N'IngredientesPlatillos', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'IngredientesPlatillos', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboIngredientesPlatillos', @del_cmd = N'CALL sp_MSdel_dboIngredientesPlatillos', @upd_cmd = N'SCALL sp_MSupd_dboIngredientesPlatillos'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'LineasCompras', @source_owner = N'dbo', @source_object = N'LineasCompras', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'LineasCompras', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboLineasCompras', @del_cmd = N'CALL sp_MSdel_dboLineasCompras', @upd_cmd = N'SCALL sp_MSupd_dboLineasCompras'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Platillos', @source_owner = N'dbo', @source_object = N'Platillos', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Platillos', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboPlatillos', @del_cmd = N'CALL sp_MSdel_dboPlatillos', @upd_cmd = N'SCALL sp_MSupd_dboPlatillos'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'Restaurantes', @source_owner = N'dbo', @source_object = N'Restaurantes', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'Restaurantes', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dboRestaurantes', @del_cmd = N'CALL sp_MSdel_dboRestaurantes', @upd_cmd = N'SCALL sp_MSupd_dboRestaurantes'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sysdiagrams', @source_owner = N'dbo', @source_object = N'sysdiagrams', @type = N'logbased', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'manual', @destination_table = N'sysdiagrams', @destination_owner = N'dbo', @vertical_partition = N'false', @ins_cmd = N'CALL sp_MSins_dbosysdiagrams', @del_cmd = N'CALL sp_MSdel_dbosysdiagrams', @upd_cmd = N'SCALL sp_MSupd_dbosysdiagrams'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'createAdministrador', @source_owner = N'dbo', @source_object = N'createAdministrador', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'createAdministrador', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'createBitacora', @source_owner = N'dbo', @source_object = N'createBitacora', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'createBitacora', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'createCliente', @source_owner = N'dbo', @source_object = N'createCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'createCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'createIngrediente', @source_owner = N'dbo', @source_object = N'createIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'createIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'createRestaurante', @source_owner = N'dbo', @source_object = N'createRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'createRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'deleteAdministrador', @source_owner = N'dbo', @source_object = N'deleteAdministrador', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'deleteAdministrador', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'deleteCliente', @source_owner = N'dbo', @source_object = N'deleteCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'deleteCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'deleteIngrediente', @source_owner = N'dbo', @source_object = N'deleteIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'deleteIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findAdministrador', @source_owner = N'dbo', @source_object = N'findAdministrador', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findAdministrador', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findCategoriaIngrediente', @source_owner = N'dbo', @source_object = N'findCategoriaIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findCategoriaIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findCategoriaRestaurante', @source_owner = N'dbo', @source_object = N'findCategoriaRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findCategoriaRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findCliente', @source_owner = N'dbo', @source_object = N'findCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findCuadra', @source_owner = N'dbo', @source_object = N'findCuadra', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findCuadra', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findIngrediente', @source_owner = N'dbo', @source_object = N'findIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'findRestaurante', @source_owner = N'dbo', @source_object = N'findRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'findRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'generarClientes', @source_owner = N'dbo', @source_object = N'generarClientes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'generarClientes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'generarPlatillos', @source_owner = N'dbo', @source_object = N'generarPlatillos', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'generarPlatillos', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'generarTodosPlatillos', @source_owner = N'dbo', @source_object = N'generarTodosPlatillos', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'generarTodosPlatillos', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getCategoriasIngredientes', @source_owner = N'dbo', @source_object = N'getCategoriasIngredientes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getCategoriasIngredientes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getCategoriasRestaurantes', @source_owner = N'dbo', @source_object = N'getCategoriasRestaurantes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getCategoriasRestaurantes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getCliente', @source_owner = N'dbo', @source_object = N'getCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getCompraCliente', @source_owner = N'dbo', @source_object = N'getCompraCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getCompraCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getDistanciasRestaurantes', @source_owner = N'dbo', @source_object = N'getDistanciasRestaurantes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getDistanciasRestaurantes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getIngredientesPorPlato', @source_owner = N'dbo', @source_object = N'getIngredientesPorPlato', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getIngredientesPorPlato', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getIngredientesRestaurante', @source_owner = N'dbo', @source_object = N'getIngredientesRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getIngredientesRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getPlatillosRestaurante', @source_owner = N'dbo', @source_object = N'getPlatillosRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getPlatillosRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getRestaurantes', @source_owner = N'dbo', @source_object = N'getRestaurantes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getRestaurantes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getUbicacionRestaurante', @source_owner = N'dbo', @source_object = N'getUbicacionRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getUbicacionRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVecinosRestaurante', @source_owner = N'dbo', @source_object = N'getVecinosRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVecinosRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVentas7dias', @source_owner = N'dbo', @source_object = N'getVentas7dias', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVentas7dias', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVentas7diasAUX', @source_owner = N'dbo', @source_object = N'getVentas7diasAUX', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVentas7diasAUX', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVentasIngrediente', @source_owner = N'dbo', @source_object = N'getVentasIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVentasIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVentasRestaurante', @source_owner = N'dbo', @source_object = N'getVentasRestaurante', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVentasRestaurante', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'getVentasRestaurantes', @source_owner = N'dbo', @source_object = N'getVentasRestaurantes', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'getVentasRestaurantes', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'init', @source_owner = N'dbo', @source_object = N'init', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'init', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'linkRestauranteIngrediente', @source_owner = N'dbo', @source_object = N'linkRestauranteIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'linkRestauranteIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'realizarCompra', @source_owner = N'dbo', @source_object = N'realizarCompra', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'realizarCompra', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_alterdiagram', @source_owner = N'dbo', @source_object = N'sp_alterdiagram', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_alterdiagram', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_creatediagram', @source_owner = N'dbo', @source_object = N'sp_creatediagram', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_creatediagram', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_dropdiagram', @source_owner = N'dbo', @source_object = N'sp_dropdiagram', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_dropdiagram', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_helpdiagramdefinition', @source_owner = N'dbo', @source_object = N'sp_helpdiagramdefinition', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_helpdiagramdefinition', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_helpdiagrams', @source_owner = N'dbo', @source_object = N'sp_helpdiagrams', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_helpdiagrams', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_renamediagram', @source_owner = N'dbo', @source_object = N'sp_renamediagram', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_renamediagram', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'sp_upgraddiagrams', @source_owner = N'dbo', @source_object = N'sp_upgraddiagrams', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'sp_upgraddiagrams', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'updateCliente', @source_owner = N'dbo', @source_object = N'updateCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'updateCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'updateIngrediente', @source_owner = N'dbo', @source_object = N'updateIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'updateIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'updateUnidadesIngrediente', @source_owner = N'dbo', @source_object = N'updateUnidadesIngrediente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'updateUnidadesIngrediente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'validateAdministrador', @source_owner = N'dbo', @source_object = N'validateAdministrador', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'validateAdministrador', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'validateCliente', @source_owner = N'dbo', @source_object = N'validateCliente', @type = N'proc schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'validateCliente', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'fn_diagramobjects', @source_owner = N'dbo', @source_object = N'fn_diagramobjects', @type = N'func schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'fn_diagramobjects', @destination_owner = N'dbo'
GO




use [RESTAURANTES]
exec sp_addarticle @publication = N'Transaccional', @article = N'verifyPlatillo', @source_owner = N'dbo', @source_object = N'verifyPlatillo', @type = N'func schema only', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x0000000008000001, @destination_table = N'verifyPlatillo', @destination_owner = N'dbo'
GO




